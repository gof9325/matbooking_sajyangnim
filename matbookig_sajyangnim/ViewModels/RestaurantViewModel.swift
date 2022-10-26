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
//    @Published var loadedRestaurant = false
    
    // 가게 정보 생성 이벤트
    var setRestaurantInfo = PassthroughSubject<(), Never>()
    
    func getRestaurantExists() {
        print("RestaurantViewModel - getRestaurantExists() called")
        RestaurantApiService.getRestaurantExists()
            .sink(receiveCompletion: { completion in
                print("RestaurantViewModel getRestaurantExists completion: \(completion)")
            }, receiveValue: { restaurantExists in
                if restaurantExists.data.exists {
                    self.getRestaurantInfo()
                }
//                else {
//                    self.setRestaurantInfo.send()
//                }
            }).store(in: &subscription)
    }
    
    func getRestaurantInfo() {
        print("RestaurantViewModel - getRestaurantInfo() called")
        
        RestaurantApiService.getRestaurantInfo()
            .sink(receiveCompletion: { completion in
                print("RestaurantViewModel getRestaurantInfo completion: \(completion)")
            }, receiveValue: { restaurantInfo in
//                self.myRestaurant = Restaurant(id: restaurantInfo.data., name: <#T##String#>, description: <#T##String#>)
            }).store(in: &subscription)
    }
    
    func createRestaurant() {
        
    }
}
