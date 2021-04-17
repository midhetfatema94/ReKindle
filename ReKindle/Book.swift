//
//  Book.swift
//  ReKindle
//
//  Created by Midhet Sulemani on 4/17/21.
//

import Foundation

class Book {
    
    var id: String
    var title: String
    var author: String
    var ownerId: String
    var edition: String?
    var imageUrlString: String?
    
    init() {
        id = ""
        title = ""
        author = ""
        ownerId = ""
    }
}
