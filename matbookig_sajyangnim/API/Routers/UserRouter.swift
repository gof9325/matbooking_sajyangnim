//
//  UserRouter.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import Foundation
import Alamofire

enum UserRouter: URLRequestConvertible {
    
    case getUserInfo
    
    var baseURL: URL {
        return URL(string:ApiClient.BASE_URL)!
    }
    
    var endPoint: String {
        switch self {
        case .getUserInfo:
            return "store-owners/me"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUserInfo :
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .getUserInfo:
            return Parameters()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        return request
    }
}
