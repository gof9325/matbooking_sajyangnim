//
//  Restaurant.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/11.
//

import Foundation

struct Restaurant: Equatable, Codable {
    var id: String
    var reservationRestrictions = ReservationRestrictions()
    var storeInfo = StoreInfo()
    
    struct ReservationRestrictions: Codable, Equatable {
        var paxMin = 2
        var paxMax = 4
        var slotGapMinutes = 60
        var daysReservableInFuture = 1
//        var openingHours = [String: OpeningHours]()
        var openingHours = ["0": OpeningHours(start: "1", end: "1")]
        
//        init(openingHours: [String: OpeningHours]) {
//            self.openingHours = openingHours
//        }
        
        struct OpeningHours: Codable, Equatable {
            var start = ""
            var end = ""
        }
    }
    
    struct StoreInfo: Codable, Equatable {
        var name = ""
        var subtitle = "없음"
        var pictures: String?
        var description = ""
        var address = ""
        var phone = "021234"
        var openingHours = "9"
        var city = "부산"
        var cuisine = "한식"
    }
}
