//
//  ChatApiService.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/11/23.
//

import Foundation
import Alamofire
import Combine

enum ChatApiService {
    static func getChatList() -> AnyPublisher<[ChatListResponse], AFError> {
        print("ChatApiService - getChatList() called")
        
        return ApiClient.shared.session
            .request(ChatRouter.getChatList)
            .publishDecodable(type: ApiResponse<[ChatListResponse]>.self)
            .value()
            .map{ $0.data }
            .eraseToAnyPublisher()
    }
    
}

