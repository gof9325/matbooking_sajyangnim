//
//  RestaurantViewModel.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/11.
//

import Foundation
import Combine
import Alamofire

class RestaurantViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    
    @Published var myRestaurant: Restaurant?
    
    func sendImage(imageData: [Data], taskId: String) {
        print("RestaurantViewModel - sendImage() called")
        RestaurantApiService.sendImage(imageData: imageData, taskId: taskId)
            .sink(receiveCompletion: { completion in
                print("RestaurantViewModel sendImage completion: \(completion)")
            }, receiveValue: { result in
                print("RestaurantViewModel - sendImage() result: \(result)")
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
                self.myRestaurant = restaurantInfo.data
            }).store(in: &subscription)
    }
    
    func modifyRestaurant(newRestaurant: Restaurant) {
        print("RestaurantViewModel - modifyRestaurant() called")
        RestaurantApiService.modifyRestaurant(newRestaurant: newRestaurant)
            .sink(receiveCompletion: { completion in
                print("RestaurantViewModel modifyRestaurant completion: \(completion)")
            }, receiveValue: { restaurantInfo in
                print("restaurantInfo: \(restaurantInfo)")
                self.myRestaurant = restaurantInfo.data
            }).store(in: &subscription)
    }
}
