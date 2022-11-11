//
//  Restaurant.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/11.
//

import Foundation

struct Restaurant: Equatable, Codable {
    var id: String
    var reservationRestrictions = ReservationRestrictions(paxMin: 1, paxMax: 2, slotGapMinutes: 60, daysReservableInFuture: 0, openingHours: ["0": OpeningHours(start: "09:00", end: "22:00")])
    var storeInfo = StoreInfo(name: "", subtitle: "", picturesFolderId: nil, pictures: nil, description: "", address: "", phone: "", openingHours: "", city: "", cuisine: "한식")
    var imagesData = [Data]()
    
}
