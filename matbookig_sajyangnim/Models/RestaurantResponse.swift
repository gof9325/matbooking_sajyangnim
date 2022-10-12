//
//  RestaurantResponse.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/11.
//

import Foundation

// MARK: - RestaurantResponse
struct RestaurantResponse: Codable {
    let reservationRestrictions: ReservationRestrictions
    let storeInfo: StoreInfo
}

// MARK: - ReservationRestrictions
struct ReservationRestrictions: Codable {
    let paxMin, paxMax, slotGapMinutes, daysReservableInFuture: Int
    let openingHours: OpeningHours
}

// MARK: - OpeningHours
struct OpeningHours: Codable {
    let additionalPropList: [AdditionalProp]
}

// MARK: - AdditionalProp
struct AdditionalProp: Codable {
    let start, end: String
}

// MARK: - StoreInfo
struct StoreInfo: Codable {
    let name, subtitle, pictures, storeInfoDescription: String
    let address, phone, openingHours, city: String
    let cuisine: String

    enum CodingKeys: String, CodingKey {
        case name, subtitle, pictures
        case storeInfoDescription = "description"
        case address, phone, openingHours, city, cuisine
    }
}
