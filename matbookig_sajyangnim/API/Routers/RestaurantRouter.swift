//
//  RestaurantRouter.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/11.
//

import Foundation
import Alamofire

enum ImageRouter: URLRequestConvertible {
    case sendImage
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: ApiClient.BASE_URL)!.appendingPathComponent("files")
        var request = URLRequest(url: url)
        request.method = .post
        
        return request
        
    }
    
}

enum RestaurantRouter: URLRequestConvertible {
    
    case getRestaurantExist
    case createRestaurant(newRestaurant: Restaurant)
    case getRestaurantInfo(id: String)
    case modifyRestaurant(newRestaurant: Restaurant)
    case sendImage(taskId: String)
    
    private var baseURL: URL {
        return URL(string:ApiClient.BASE_URL)!
    }
    
    private var endPoint: String {
        switch self {
        case .getRestaurantExist, .modifyRestaurant:
            return "stores/my"
        case .createRestaurant:
            return "stores"
        case let .getRestaurantInfo(id):
            return "stores/\(id)"
        case .sendImage:
            return "files"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getRestaurantExist, .getRestaurantInfo:
            return .get
        case .createRestaurant, .sendImage:
            return .post
        case .modifyRestaurant:
            return .patch
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case .getRestaurantExist:
            return Parameters()
        case let .getRestaurantInfo(id):
            var parameters = Parameters()
            parameters["id"] = id
            return parameters
        case let .createRestaurant(newRestaurant), let .modifyRestaurant(newRestaurant):
            do {
                let dictionary = try newRestaurant.encode()
                print(dictionary)
                return dictionary
            } catch {
                print(error)
                return [String: Any]()
            }
        case let .sendImage(taskId):
            var parameters = Parameters()
            parameters["taskId"] = taskId
            return parameters
        }
        
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        
        if method == .post || method == .patch {
                request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
        }

        return request
    }
}
