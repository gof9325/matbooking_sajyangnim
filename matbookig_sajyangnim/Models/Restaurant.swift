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
    var taskId: String?
    
    struct ReservationRestrictions: Codable, Equatable {
        var paxMin = 2
        var paxMax = 4
        var slotGapMinutes = 60
        var daysReservableInFuture = 1
        var openingHours = [
            "0": OpeningHours(start: "09:00", end: "22:00"),
            "1": OpeningHours(start: "09:00", end: "22:00"),
            "2": OpeningHours(start: "09:00", end: "22:00"),
            "3": OpeningHours(start: "09:00", end: "22:00"),
            "4": OpeningHours(start: "09:00", end: "22:00"),
            "5": OpeningHours(start: "09:00", end: "22:00"),
            "6": OpeningHours(start: "09:00", end: "22:00")
        ]
    
        struct OpeningHours: Codable, Equatable {
            var start = ""
            var end = ""
        }
    }
    
    struct StoreInfo: Codable, Equatable {
        var name = ""
        var subtitle = "없음"
        var picturesFolderId: String?
        var description = ""
        var address = ""
        var phone = "021234"
        var openingHours = ""
        var city = "부산"
        var cuisine = "한식"
        var pictures: [ImageUploadResponse]?
    }
}
