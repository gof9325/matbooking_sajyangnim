//
//  RestaurantViewModel.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/11.
//

import Foundation
import Combine
import Alamofire
import UIKit

class RestaurantViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    
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
//            print("i.url: \(i.url)")
            return i.url
        }
        
        imageUrls.publisher.flatMap { url in
            self.makePublisherForUrl(url: url)
        }.collect()
        .sink(receiveCompletion: { completion in
            print("RestaurantViewModel getImages completion: \(completion)")
            switch completion {
            case .failure(let err):
                print("err: \(err)")
            case .finished:
                print("finished")
            }
        }, receiveValue: { valueTups in
            for valueTup in valueTups {
                let url = valueTup.1
                let imagedata = valueTup.0
                print("ReceiveValue url: \(url)")
            }
            self.myRestaurant?.imagesData = valueTups.map {
                $0.0
            }
//            self.myRestaurant?.imagesData.append(contentsOf: imageData)
        }).store(in: &subscription)
                
        
        
        // ---Original, zipless version--
//        imageUrls.publisher.flatMap { url in
//            RestaurantApiService.downloadImage(url: url)
//        }.collect()
//        .sink(receiveCompletion: { completion in
//            print("RestaurantViewModel getImages completion: \(completion)")
//            switch completion {
//            case .failure(let err):
//                print("err: \(err)")
//            case .finished:
//                print("finished")
//            }
//        }, receiveValue: { imageData in
//            self.myRestaurant?.imagesData = imageData
////            self.myRestaurant?.imagesData.append(contentsOf: imageData)
//        }).store(in: &subscription)
        
//        _ = imageUrls.compactMap { url in
//            RestaurantApiService.downloadImage(url: url)
//                .sink(receiveCompletion:{ completion in
//                    print("RestaurantViewModel getImages completion: \(completion)")
//                }, receiveValue:{ imageData in
//                    self.myRestaurant?.imagesData.append(imageData)
//                }).store(in: &subscription)
//        }
        
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
            }, receiveValue: { restaurantInfo in
                print("restaurantInfo: \(restaurantInfo)")
                self.myRestaurant = restaurantInfo.data.convertToRestaurant()
            }).store(in: &subscription)
    }
    
//    func makeUIImageArray() -> [UIImage] {
//        var UIImageList = [UIImage]()
//
//        if let pictures = myRestaurant?.storeInfo.pictures {
//            for imageResponse in pictures {
//
//                let url = URL(string: imageResponse.url!) //입력받은 url string을 URL로 변경
//                        //main thread에서 load할 경우 URL 로딩이 길면 화면이 멈춘다.
//                        //이를 방지하기 위해 다른 thread에서 처리함.
//                        DispatchQueue.global().async { [weak self] in
//                            if let data = try? Data(contentsOf: url!) {
//                                if let image = UIImage(data: data) {
//                                    //UI 변경 작업은 main thread에서 해야함.
//                                    DispatchQueue.main.async {
//                                        self?.photoImageView.image = image
//                                    }
//                                }
//                            }
//                        }
//
//
//            }
//        }
//    }
    
}
