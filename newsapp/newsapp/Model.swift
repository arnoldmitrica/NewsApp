//
//  Model.swift
//  newsapp
//
//  Created by Arnold Mitricã on 10.03.2021.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String?

//    enum CodingKeys: String, CodingKey {
//        case source, author, title
//        case articleDescription = "description"
//        case url, urlToImage, publishedAt, content
//    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
