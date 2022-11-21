//
//  RestaurantViewModel.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/11.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

class RestaurantViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    
    enum GetImageState {
        case beforeLoad, loading, didLoaded
    }
    
    enum RestaurantInfoState {
        case editing, none
    }
    
    var getImageFinished = PassthroughSubject<
    [Data], Never>()
    
    @Published var restaurantInfoState: RestaurantInfoState = .none
    @Published var getImageState: GetImageState = .beforeLoad
    @Published var myRestaurant: Restaurant?
    
    func makePublisherForUrl(url: String) -> AnyPublisher<(Data, String), AFError> {
        let pub1 = RestaurantApiService.downloadImage(url: url)
        let pub2 = Just(url).setFailureType(to: AFError.self)
        return Publishers.Zip(pub1, pub2).eraseToAnyPublisher()
    }
    
    func getImages() {
        print("RestaurantViewModel - getImages() called")
        
        guard let restaurantPictures = myRestaurant?.storeInfo.pictures else {
            return
        }
        
        let imageUrls = restaurantPictures.compactMap { i in
            return i.url
        }
        
        imageUrls.publisher.flatMap { url in
            self.makePublisherForUrl(url: url)
        }.collect()
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let err):
                print("RestaurantViewModel getImages err: \(err)")
            case .finished:
                print("RestaurantViewModel getImages finished")
            }
            self.getImageState = .didLoaded
        }, receiveValue: { valueTups in
            print("RestaurantViewModel getImages value receive")
            for valueTup in valueTups {
                let url = valueTup.1
                _ = valueTup.0
                print("ReceiveValue url: \(url)")
            }
            self.myRestaurant?.imagesData = valueTups.map {
                $0.0
            }
            self.getImageFinished.send(self.myRestaurant!.imagesData)
        }).store(in: &subscription)
    }
        
    func sendImage(imageData: [Data], taskId: String) {
        print("RestaurantViewModel - sendImage() called")
        RestaurantApiService.sendImage(imageData: imageData, taskId: taskId, fileFolderId: myRestaurant?.storeInfo.picturesFolderId)
            .sink(receiveCompletion: { completion in
                print("RestaurantViewModel sendImage completion: \(completion)")
            }, receiveValue: { result in
                print("RestaurantViewModel - sendImage() result: \(result)")
                if !result.data.isEmpty {
                    self.myRestaurant?.storeInfo.picturesFolderId = result.data[0].fileFolderId
                }
            }).store(in: &subscription)
    }

    func getRestaurantInfo(id: String) {
        print("RestaurantViewModel - getRestaurantInfo() called")
        RestaurantApiService.getRestaurantInfo(id: id)
            .sink(receiveCompletion: { completion in
                print("RestaurantViewModel getRestaurantInfo completion: \(completion)")
            }, receiveValue: { restaurantInfo in
                self.myRestaurant = Restaurant(id: id, reservationRestrictions: restaurantInfo.data.reservationRestrictions, storeInfo: restaurantInfo.data.storeInfo)
            }).store(in: &subscription)
    }
    
    func createRestaurant(newRestaurant: Restaurant, taskId: String?) {
        print("RestaurantViewModel - createRestaurant() called")
        let storeInfo = newRestaurant.storeInfo
        
        let restaurantRequest = RestaurantRequest(reservationRestrictions: newRestaurant.reservationRestrictions, storeInfo: RestaurantRequest.StoreInfo(name: storeInfo.name, subtitle: storeInfo.subtitle, picturesFolderId: storeInfo.picturesFolderId ?? "", description: storeInfo.description, address: storeInfo.address, phone: storeInfo.phone, openingHours: storeInfo.openingHours, city: storeInfo.city, cuisine: storeInfo.cuisine), taskId: taskId ?? nil)
        
        RestaurantApiService.createRestaurant(newRestaurant: restaurantRequest)
            .sink(receiveCompletion: { completion in
                print("RestaurantViewModel createRestaurant completion: \(completion)")
            }, receiveValue: { restaurantInfo in
                print("restaurantInfo: \(restaurantInfo)")
                self.myRestaurant = restaurantInfo.data.convertToRestaurant()
            }).store(in: &subscription)
    }
    
    func modifyRestaurant(newRestaurant: Restaurant, taskId: String?) {
        print("RestaurantViewModel - modifyRestaurant() called")
        let storeInfo = newRestaurant.storeInfo
        
        let restaurantRequest = RestaurantRequest(reservationRestrictions: newRestaurant.reservationRestrictions, storeInfo: RestaurantRequest.StoreInfo(name: storeInfo.name, subtitle: storeInfo.subtitle, picturesFolderId: storeInfo.picturesFolderId ?? "", description: storeInfo.description, address: storeInfo.address, phone: storeInfo.phone, openingHours: storeInfo.openingHours, city: storeInfo.city, cuisine: storeInfo.cuisine), taskId: taskId ?? nil)
        
        RestaurantApiService.modifyRestaurant(newRestaurant: restaurantRequest)
            .sink(receiveCompletion: { completion in
                print("RestaurantViewModel modifyRestaurant completion: \(completion)")
                switch completion {
                case .finished:
                    self.getImages()
                    self.restaurantInfoState = .none
                    break
                case .failure(let err):
                    print("err: \(err)")
                    break
                }
            }, receiveValue: { restaurantInfo in
                print("restaurantInfo: \(restaurantInfo)")
                self.myRestaurant =  restaurantInfo.data.convertToRestaurant()
            }).store(in: &subscription)
    }
    
}
