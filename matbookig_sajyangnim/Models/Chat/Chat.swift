//
//  Chat.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/11/23.
//

import Foundation

struct ChatSocketSend: Codable, Hashable {
    var id = UUID()
    var event = "message-to-customer"
    let data: ChatData
    
    struct ChatData: Codable, Hashable {
        let to: String
        let message: String
    }
}
