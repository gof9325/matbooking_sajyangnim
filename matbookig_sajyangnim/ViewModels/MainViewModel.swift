//
//  ContentViewModel.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/24.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    
    private var subscription = Set<AnyCancellable>()
    
    var ownerVM: OwnerViewModel?
    var restaurantVM: RestaurantViewModel?
    
    var dataLoaded = PassthroughSubject<(Owner?, Restaurant?), Never>()
    
    func getOwnerAndRestaurantExists() {
        Publishers.Zip(OwnerApiService.getOwnerInfo(), RestaurantApiService.getRestaurantExist())
            .sink(receiveCompletion: { completion in
                print("completion : \(completion)")
                switch completion {
                case .failure(let error):
                    print("errr \(error)")
                    break
                case .finished:
                    break
                }

            }, receiveValue: { result in
                print(result)
                let owner = result.0.data
                let restaurant = result.1.data
                var newOwner: Owner?
                var newRestaurant: Restaurant?

                if owner.exists {
                    newOwner = Owner(name: owner.name!, mobile: owner.mobile!)
                    self.ownerVM?.owner = newOwner
                    if restaurant.exists {
//                        self.restaurantVM?.createRestaurant()
                        newRestaurant = self.restaurantVM?.myRestaurant
                    }
                }
                self.dataLoaded.send((newOwner, newRestaurant))
            }).store(in: &subscription)
    }
    
}
