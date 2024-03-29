//
//  BaseInterceptor.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import Foundation
import Alamofire

class BaseInterceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        completion(.success(request))
    }
}
