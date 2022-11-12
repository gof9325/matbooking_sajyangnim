//
//  Reservation.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/11/12.
//

import Foundation

struct Reservation: Codable, Hashable {
    let date: String
    let customer: Customer
    let pax: Int
    
    struct Customer: Codable, Hashable {
        let name: String
        let id: String
    }
}
