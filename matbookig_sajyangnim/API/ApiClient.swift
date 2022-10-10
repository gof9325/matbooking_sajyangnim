//
//  ApiClient.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import Foundation
import Alamofire

final class ApiClient {
    
    static let shared = ApiClient()
    
    static let BASE_URL = "http://165.22.105.229:3000/"
    
    let interceptors = Interceptor(interceptors: [
        BaseInterceptor(),
        Auth0Interceptor()
    ])
    
    let monitors = [ApiLogger()] as [EventMonitor]
    
    var session: Session
    
    init() {
        print("ApiClient - init() called")
        session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
}
