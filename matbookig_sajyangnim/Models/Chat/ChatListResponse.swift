//
//  ChatListResponse.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/11/23.
//

import Foundation

struct ChatListResponse: Codable, Hashable {
    let message: String
    let customer: Customer
    let createdAt: String
    
}

struct Customer: Codable, Hashable {
    let id: String
    let name: String
}
