//
//  ReservationService.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/11/12.
//

import Foundation
import Alamofire
import Combine

enum ReservationApiService {
    
    static func getReservations() -> AnyPublisher<ApiResponse<[Reservation]>, AFError> {
        print("ReservationApiService - getReservations() called")
        return ApiClient.shared.session
            .request(ReservationRouter.getReservations)
            .publishDecodable(type: ApiResponse<[Reservation]>.self)
            .value()
            .eraseToAnyPublisher()
    }
}
