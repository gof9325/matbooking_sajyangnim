//
//  OwnerRouter.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import Foundation
import Alamofire

enum OwnerRouter: URLRequestConvertible {
    
    case getOwnerInfo
    case join(name: String, mobile: String)
    
    private var baseURL: URL {
        return URL(string:ApiClient.BASE_URL)!
    }
    
    private var endPoint: String {
        switch self {
        case .getOwnerInfo:
            return "store-owners/me"
        case .join:
            return "store-owners"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getOwnerInfo:
            return .get
        case .join:
            return .post
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case .getOwnerInfo:
            return Parameters()
        case let .join(name, mobile):
            var parameters = Parameters()
            parameters["name"] = name
            parameters["mobile"] = mobile
            return parameters
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
