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
    
    init(details: [String: Any]) {
        id = details["id"] as? String ?? ""
        title = details["title"] as? String ?? ""
        author = details["author"] as? String ?? ""
        ownerId = details["ownerId"] as? String ?? ""
        edition = details["edition"] as? String
        imageUrlString = details["bookImageUrl"] as? String
    }
}
