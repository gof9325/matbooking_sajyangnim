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
    
    static func sendImage(imageData: [Data], taskId: String, fileFolderId: String?) -> AnyPublisher<ApiResponse<[ImageUploadResponse]>, AFError> {
        print("RestaurantApiService - sendImage() called")
        return ApiClient.imageUploadShared.session
            .upload(multipartFormData: { multipartFormData in
                if fileFolderId != nil {
                    multipartFormData.append(fileFolderId!.data(using: .utf8)!, withName: "fileFolderId")
                }
                multipartFormData.append(taskId.data(using: .utf8)!, withName: "taskId")
                for data in imageData {
                    multipartFormData.append(data, withName: "files", fileName: "\(taskId).png" ,mimeType: "image/png")
                }
            }, with: ImageRouter.sendImage)
            .responseString { response in
                print("RestaurantApiService - sendImage() response: \(response)")
            }
            .publishDecodable(type: ApiResponse<[ImageUploadResponse]>.self)
            .value()
            .eraseToAnyPublisher()
    }
    
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
