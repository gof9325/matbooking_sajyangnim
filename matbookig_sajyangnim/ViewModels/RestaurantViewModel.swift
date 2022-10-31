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
    
//    func getRestaurantExist() {
//        print("RestaurantViewModel - getRestaurantExist() called")
//        RestaurantApiService.getRestaurantExist()
//            .sink(receiveCompletion: { completion in
//                print("RestaurantViewModel getRestaurantExist completion: \(completion)")
//            }, receiveValue: { restaurantInfo in
//                print("0-0")
//                if restaurantInfo.data.exists {
//                    print("0-1")
//                    self.myRestaurant = Restaurant()
//                    print("restaurantInfo: \(restaurantInfo.data)")
//                }
//            }).store(in: &subscription)
//    }
    
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
}
