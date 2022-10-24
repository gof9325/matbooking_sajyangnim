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
    static func getRestaurantExists() -> AnyPublisher<ApiResponse<RestaurantExistsResponse>, AFError> {
        print("RestaurantApiService - getRestaurantExists() called")
        return ApiClient.shared.session
            .request(RestaurantRouter.getRestaurantExists)
            .publishDecodable(type: ApiResponse<RestaurantExistsResponse>.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    static func getRestaurantInfo() -> AnyPublisher<ApiResponse<RestaurantResponse>, AFError> {
        print("RestaurantApiService - getRestaurantInfo() called")
        return ApiClient.shared.session
            .request(RestaurantRouter.getRestaurantInfo)
            .publishDecodable(type: ApiResponse<RestaurantResponse>.self)
            .value()
            .eraseToAnyPublisher()
    }
}
