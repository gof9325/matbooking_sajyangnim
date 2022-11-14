//
//  Common.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/11/10.
//

import Foundation

struct ReservationRestrictions: Codable, Equatable {
    var paxMin: Int
    var paxMax: Int
    var slotGapMinutes: Int
    var daysReservableInFuture: Int
    var openingHours: [String:OpeningHours]
}

struct StoreInfo: Codable, Equatable{
    var name: String
    var subtitle: String
    var picturesFolderId: String?
    var pictures: [ImageResponse]?
    var description: String
    var address: String
    var phone: String
    var openingHours: String
    var city: String
    var cuisine: String
}

struct OpeningHours: Codable, Equatable {
    var start: String
    var end: String
}
