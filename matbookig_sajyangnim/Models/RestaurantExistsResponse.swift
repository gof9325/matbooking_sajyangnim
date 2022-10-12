//
//  RestaurantResponse.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/11.
//

import Foundation

struct RestaurantExistsResponse: Codable {
    let exists: Bool
    let store: String?
}
