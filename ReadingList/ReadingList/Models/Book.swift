//
//  Book.swift
//  ReadingList
//
//  Created by Diante Lewis-Jolley on 1/19/23.
//

import Foundation

struct Book: Codable, Equatable {
    
    
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool

    
    init(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
    }
}
