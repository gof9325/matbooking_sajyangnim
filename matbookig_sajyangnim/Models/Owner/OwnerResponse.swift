//
//  UserResponse.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import Foundation

// MARK: - OwnerResponse
struct OwnerResponse: Codable {
    let exists: Bool
    let name: String?
    let mobile: String?
}
