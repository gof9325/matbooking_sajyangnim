//
//  UserService.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import Foundation
import Alamofire
import Combine

enum UserApiService {
    static func getUserInfo() -> AnyPublisher<ApiResponse<UserResponse>, AFError> {
        print("UserApiService - getUserInfo() called")
        
        return ApiClient.shared.session
            .request(UserRouter.getUserInfo)
            .publishDecodable(type: ApiResponse<UserResponse>.self)
            .value()
            .eraseToAnyPublisher()
    }
}
