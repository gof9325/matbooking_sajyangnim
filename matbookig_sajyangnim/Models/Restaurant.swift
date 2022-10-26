//
//  Restaurant.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/11.
//

import Foundation

struct Restaurant: Equatable, Identifiable, Codable {
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    var reservationRestrictions = ReservationRestrictions()
    var storeInfo = StoreInfo()
    
    struct ReservationRestrictions: Codable {
        var paxMin = 0
        var paxMax = 0
        var slotGapMinutes = 0
        var daysReservableInFuture = 0
        var openingHours = [OpeningHours()]
        
        struct OpeningHours: Codable {
            var additionalProp = AdditionalProp()
            
            struct AdditionalProp: Codable {
                var start = ""
                var end = ""
            }
        }
    }

    struct StoreInfo: Codable {
        var name = ""
        var subtitle = ""
        var prictures = ""
        var description = ""
        var address = ""
        var phone = ""
        var openingHours = ""
        var city = ""
        var cuisine = ""
    }
}
