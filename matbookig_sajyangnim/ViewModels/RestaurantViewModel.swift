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
    
    func getImages() {
        print("RestaurantViewModel - getImages() called")
        
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
    
    func createRestaurant(newRestaurant: Restaurant) {
        print("RestaurantViewModel - createRestaurant() called")
        RestaurantApiService.createRestaurant(newRestaurant: newRestaurant)
            .sink(receiveCompletion: { completion in
                print("RestaurantViewModel createRestaurant completion: \(completion)")
            }, receiveValue: { restaurantInfo in
                print("restaurantInfo: \(restaurantInfo)")
                self.myRestaurant = restaurantInfo.data.convertToRestaurant()
            }).store(in: &subscription)
    }
    
    func modifyRestaurant(newRestaurant: Restaurant) {
        print("RestaurantViewModel - modifyRestaurant() called")
        RestaurantApiService.modifyRestaurant(newRestaurant: newRestaurant)
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
