//
//  ApiResponse.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/10.
//

import Foundation

// MARK: - ApiResponse
struct ApiResponse<T>: Codable where T: Codable {
    let success: Bool
    let error: String
    let data: T
    let message: String
}
