//
//  ChatRouter.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/11/23.
//

import Foundation
import Alamofire

enum ChatRouter: URLRequestConvertible {
    
    case getChatList
    
    private var baseURL: URL {
        return URL(string:ApiClient.BASE_URL)!
    }
    
    private var endPoint: String {
        switch self {
        case .getChatList:
            return "stores/my/chat-messages"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getChatList:
            return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        return request
    }

}
