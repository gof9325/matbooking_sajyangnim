//
//  ImageResponse.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/11/07.
//

import Foundation

struct ImageResponse: Codable, Equatable {
    let id: String
    let fileFolderId: String
    let url: String?
}
