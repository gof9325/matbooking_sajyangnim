//
//  ReservationViewModel.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/11/12.
//

import Foundation
import Combine
import Alamofire

class ReservationViewModel: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    
    enum ReservationLoadingState {
        case beforeLoaded, didLoaded, loadSuccess, loadFail
    }
    
    @Published var reservationLoadingState: ReservationLoadingState = .beforeLoaded
    @Published var reservationList: [Reservation]?
    
    func getReservations() {
        print("ReservationViewModel - getReservations() called")
        ReservationApiService.getReservations()
            .sink(receiveCompletion: { completion in
                print("ReservationViewModel getReservations completion: \(completion)")
                switch completion {
                case .finished:
                    self.reservationLoadingState = .didLoaded
                case .failure(_):
                    self.reservationLoadingState = .loadFail
                }
            }, receiveValue: { reservations in
                let resultList = reservations.data
                self.reservationList = [Reservation]()
                for reservation in resultList {
                    self.reservationList?.append(Reservation(date: reservation.date, customer: reservation.customer, pax: reservation.pax))
                }
            }).store(in: &subscription)
    }
}
