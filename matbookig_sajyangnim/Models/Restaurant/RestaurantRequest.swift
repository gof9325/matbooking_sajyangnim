//
//  RestaurantRequest.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/11/16.
//

import Foundation

struct RestaurantRequest: Codable {
    let reservationRestrictions: ReservationRestrictions
    let storeInfo: StoreInfo
    let taskId: String?
    
    struct StoreInfo: Codable {
        let name: String
        let subtitle: String
        let picturesFolderId: String
        let description: String
        let address: String
        let phone: String
        let openingHours: String
        let city: String
        let cuisine: String
    }
}
