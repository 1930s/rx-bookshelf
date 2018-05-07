//
//  MockBooks.swift
//  RxBookshelfTests
//
//  Created by Mario on 6/5/18.
//  Copyright © 2018 Mario Negro. All rights reserved.
//

import Foundation
import RxSwift
import RxBlocking
@testable import RxBookshelf

var dummyBooks: Observable<[Book]> {
    return data.mapBooks()
}

var rawDummyBooks: [Book] {
    return try! data.mapBooks().toBlocking().single()
}

var dummyBook: Observable<Book> {
    return dummyBooks.map({ $0.first! })
}

var rawDummyBook: Book {
    return rawDummyBooks.first!
}

private let data: Observable<Data> = {
    let string = """
        [
          {
            "title": "Book 1",
            "authors": [
              "Author 1"
            ],
            "publisher": "Publisher 1",
            "publishedDate": "21-01-1981",
            "description": "Description 1",
            "pageCount": 100,
            "coverImageUrl": "http://www.test.com",
            "isRead": false
          },
          {
            "title": "Book 2",
            "authors": [
              "Author 2"
            ],
            "publisher": "Publisher 2",
            "publishedDate": "21-01-1982",
            "description": "Description 2",
            "pageCount": 200,
            "coverImageUrl": "http://www.test.com",
            "isRead": false
          },
          {
            "title": "Book 3",
            "authors": [
              "Author 3"
            ],
            "publisher": "Publisher 3",
            "publishedDate": "21-01-1983",
            "description": "Description 3",
            "pageCount": 300,
            "coverImageUrl": "http://www.test.com",
            "isRead": true
          }
        ]
    """
    return .just(string.data(using: .utf8)!)
}()
