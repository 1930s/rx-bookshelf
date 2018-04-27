//
//  Book.swift
//  Bookshelf
//
//  Created by Mario on 25/4/18.
//  Copyright © 2018 Mario Negro. All rights reserved.
//

import Foundation

struct Book: Codable {
    let id: String
    let title: String
    let authors: [String]
    let description: String
    let publisher: String
    let publishedDate: String
    let coverImageUrl: URL?
    var coverImage: Data?
    let isRead: Bool
    
    var authorsString: String {
        return authors.joined(separator: ", ")
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, authors, description, publisher, publishedDate, coverImageUrl, isRead
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        authors = try container.decodeIfPresent([String].self, forKey: .authors) ?? []
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        publisher = try container.decodeIfPresent(String.self, forKey: .publisher) ?? ""
        publishedDate = try container.decodeIfPresent(String.self, forKey: .publishedDate) ?? ""
        coverImageUrl = try container.decodeIfPresent(URL.self, forKey: .coverImageUrl) ?? nil
        isRead = try container.decodeIfPresent(Bool.self, forKey: .isRead) ?? false
    }
}
