//
//  DetailLocal.swift
//  Mogisiro
//
//  Created by 이예은 on 2023/05/23.
//

import Foundation

struct DetailLocal: Codable {
    let result: [Result]
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let action: String
    let content: [Content]
}

// MARK: - Content
struct Content: Codable {
    let id: Int
    let title, description: String
}
