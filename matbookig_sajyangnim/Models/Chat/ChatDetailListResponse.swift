//
//  ChatDetailListResponse.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/11/23.
//

import Foundation

struct ChatDetailListResponse: Codable, Hashable {
    let id: String
    let createdAt: String
    let updatedAt: String
    let message: String
    let type: ChatDetailType
    let store: String
    let customer: String
      
}

enum ChatDetailType:String, Codable, Hashable {
    case CustomerToStore = "CUSTOMER->STORE"
    case StoreToCustomer = "STORE->CUSTOMER"
}
