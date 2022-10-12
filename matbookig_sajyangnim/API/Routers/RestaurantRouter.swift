//
//  RestaurantRouter.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/11.
//

import Foundation
import Alamofire

enum RestaurantRouter: URLRequestConvertible {
    
    case getRestaurantExists
    case getRestaurantInfo
    
    private var baseURL: URL {
        return URL(string:ApiClient.BASE_URL)!
    }
    
    private var endPoint: String {
        switch self {
        case .getRestaurantExists:
            return "stores/my"
        case .getRestaurantInfo:
            return "stores"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getRestaurantExists:
            return .get
        case .getRestaurantInfo:
            return .post
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case .getRestaurantExists, .getRestaurantInfo:
            return Parameters()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        if method == .post {
            request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
        }
        return request
    }
}
