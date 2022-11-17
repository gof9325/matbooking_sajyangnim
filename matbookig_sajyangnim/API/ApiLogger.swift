//
//  ApiLogger.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import Foundation
import Alamofire

// 이벤트 모니터 로거
// Alamofire 공식 문서 참조
final class ApiLogger: EventMonitor {
    let queue = DispatchQueue(label: "matbooking_sajyangnim_ApiLogger")
    
    // Event called when any type of Request is resumed.
    func requestDidResume(_ request: Request) {
        print("ApiLogger - Resuming: \(request)")
        if let req = request.request {
            print(req.url?.lastPathComponent)
        }

    }
    
    // Event called whenever a DataRequest has parsed a response.
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        debugPrint("ApiLogger - response: \(response))")
        debugPrint("ApiLogger - Finished: \(response) \(response.response?.statusCode)")
        if response.error != nil {
            let decoder = JSONDecoder()
            if let data = response.data {
                let json = try? decoder.decode(ApiResponse<[String:String]>.self, from: data)
                print(json)
            }
        }
    }
}
