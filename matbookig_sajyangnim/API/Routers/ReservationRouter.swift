//
//  ReservationRouter.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/11/12.
//

import Foundation
import Alamofire

enum ReservationRouter: URLRequestConvertible {
    
    case getReservations
    
    private var baseURL: URL {
        return URL(string:ApiClient.BASE_URL)!
    }
    
    private var endPoint: String {
        switch self {
        case .getReservations:
            return "stores/my/reservations"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getReservations:
            return .get
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case .getReservations:
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

