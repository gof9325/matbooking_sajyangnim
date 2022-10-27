//
//  Restaurant.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/11.
//

import Foundation

struct Restaurant: Equatable, Codable {
    var reservationRestrictions = ReservationRestrictions()
    var storeInfo = StoreInfo()
    
    struct ReservationRestrictions: Codable, Equatable {
        var paxMin = 0
        var paxMax = 0
        var slotGapMinutes = 0
        var daysReservableInFuture = 0
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
        var subtitle = ""
        var prictures = ""
        var description = ""
        var address = ""
        var phone = "021234"
        var openingHours = "9"
        var city = "부산"
        var cuisine = "한식"
    }
}
