//
//  RestaurantResponse.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/11/09.
//

import Foundation

struct RestaurantResponse: Equatable, Codable {
    var id: String
    var reservationRestrictions: ReservationRestrictions
    var storeInfo: StoreInfo
    var taskId: String?

}

extension RestaurantResponse {
    
    func convertToRestaurant() -> Restaurant {
        
        let reservationRestrictions = self.reservationRestrictions
        
        let storeInfo = self.storeInfo
        
        return Restaurant(
            id: self.id,
            reservationRestrictions:
                ReservationRestrictions(
                    paxMin: reservationRestrictions.paxMin,
                    paxMax: reservationRestrictions.paxMax,
                    slotGapMinutes: reservationRestrictions.slotGapMinutes,
                    daysReservableInFuture: reservationRestrictions.daysReservableInFuture,
                    openingHours: reservationRestrictions.openingHours),
            storeInfo:
                StoreInfo(
                    name: storeInfo.name,
                    subtitle: storeInfo.subtitle,
                    picturesFolderId: storeInfo.picturesFolderId,
                    pictures: storeInfo.pictures,
                    description: storeInfo.description,
                    address: storeInfo.address,
                    phone: storeInfo.phone,
                    openingHours: storeInfo.openingHours,
                    city: storeInfo.city,
                    cuisine: storeInfo.cuisine),
            imagesData: [Data]())
    }
    
}
