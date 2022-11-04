//
//  RestaurantApiService.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/11.
//

import Foundation
import Alamofire
import Combine

enum RestaurantApiService {
    static func getRestaurantExist() -> AnyPublisher<ApiResponse<RestaurantExistsResponse>, AFError> {
        print("RestaurantApiService - getRestaurantExist() called")
        return ApiClient.shared.session
            .request(RestaurantRouter.getRestaurantExist)
            .publishDecodable(type: ApiResponse<RestaurantExistsResponse>.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    static func getRestaurantInfo(id: String) -> AnyPublisher<ApiResponse<Restaurant>, AFError> {
        print("RestaurantApiService - getRestaurantInfo() called")
        return ApiClient.shared.session
            .request(RestaurantRouter.getRestaurantInfo(id: id))
            .publishDecodable(type: ApiResponse<Restaurant>.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    static func createRestaurant(newRestaurant: Restaurant) -> AnyPublisher<ApiResponse<Restaurant>, AFError> {
        print("RestaurantApiService - createRestaurant() called")
        return ApiClient.shared.session
            .request(RestaurantRouter.createRestaurant(newRestaurant: newRestaurant))
            .responseString { response in
                print(response)
            }
            .publishDecodable(type: ApiResponse<Restaurant>.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    static func modifyRestaurant(newRestaurant: Restaurant) -> AnyPublisher<ApiResponse<Restaurant>, AFError> {
        print("RestaurantApiService - modifyRestaurant() called")
        return ApiClient.shared.session
            .request(RestaurantRouter.modifyRestaurant(newRestaurant: newRestaurant))
            .responseString { response in
                print(response)
            }
            .publishDecodable(type: ApiResponse<Restaurant>.self)
            .value()
            .eraseToAnyPublisher()
    }
    
}
