//
//  ChatDetail.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/11/23.
//

import Foundation

struct ChatDetail: Codable, Hashable  {
    let id: String
    let createdAt: Date
    let message: String
    let type: ChatDetailType
}
