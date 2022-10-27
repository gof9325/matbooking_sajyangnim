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
    
    // 가게 정보 생성 이벤트
//    var setRestaurantInfo = PassthroughSubject<(), Never>()
    
    func getRestaurantExist() {
        print("RestaurantViewModel - getRestaurantExist() called")
        RestaurantApiService.getRestaurantExist()
            .sink(receiveCompletion: { completion in
                print("RestaurantViewModel getRestaurantExist completion: \(completion)")
            }, receiveValue: { restaurantInfo in
                if restaurantInfo.data.exists {
//                    self.myRestaurant = restaurantInfo.data.store
                    print("restaurantInfo: \(restaurantInfo.data)")
                }
            }).store(in: &subscription)
    }
    
    func getRestaurantInfo() {
        
    }
    
    func createRestaurant(newRestaurant: Restaurant) {
        print("RestaurantViewModel - createRestaurant() called")
        RestaurantApiService.createRestaurant(newRestaurant: newRestaurant)
            .sink(receiveCompletion: { completion in
                print("RestaurantViewModel createRestaurant completion: \(completion)")
            }, receiveValue: { restaurantInfo in
                print("restaurantInfo: \(restaurantInfo)")
//                self.myRestaurant = newRestaurant
            }).store(in: &subscription)
    }
}
