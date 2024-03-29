//
//  UserService.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import Foundation
import Alamofire
import Combine

enum OwnerApiService {
    static func getOwnerInfo() -> AnyPublisher<ApiResponse<OwnerResponse>, AFError> {
        print("OwnerApiService - getOwnerInfo() called")
        return ApiClient.shared.session
            .request(OwnerRouter.getOwnerInfo)
            .publishDecodable(type: ApiResponse<OwnerResponse>.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    static func join(name: String, mobile: String) -> AnyPublisher<ApiResponse<JoinResponse>, AFError> {
        print("OwnerApiService - join() called")
        return ApiClient.shared.session
            .request(OwnerRouter.join(name: name, mobile: mobile))
            .responseString { response in
                print("OwnerApiService - join() response: \(response)")
            }
            .publishDecodable(type: ApiResponse<JoinResponse>.self)
            .value()
            .eraseToAnyPublisher()
    }
}
