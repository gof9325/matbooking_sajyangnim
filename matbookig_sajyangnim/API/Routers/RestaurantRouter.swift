//
//  RestaurantRouter.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/11.
//

import Foundation
import Alamofire

enum RestaurantRouter: URLRequestConvertible {
    
    case getRestaurantExist
    case createRestaurant(newRestaurant: RestaurantRequest)
    case getRestaurantInfo(id: String)
    case modifyRestaurant(newRestaurant: RestaurantRequest)
    
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
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getRestaurantExist, .getRestaurantInfo:
            return .get
        case .createRestaurant:
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

enum ImageRouter: URLRequestConvertible {
    case sendImage
    case downloadImage(url: String)
    
    private var baseURL: URL {
        switch self {
        case let .downloadImage(url):
            return URL(string: url)!
        default:
            return URL(string: ApiClient.BASE_URL)!
        }
    }
    
    private var endPoint: String {
        switch self {
        case .sendImage:
            return "files"
        default :
            return ""
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .sendImage:
            return .post
        case .downloadImage:
            return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url: URL
        
        if !endPoint.isEmpty {
            url = baseURL.appendingPathComponent(endPoint)
        } else {
            url = baseURL
        }
        var request = URLRequest(url: url)
        request.method = method
        
        return request
    }
    
}
