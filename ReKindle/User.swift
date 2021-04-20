//
//  User.swift
//  ReKindle
//
//  Created by Midhet Sulemani on 4/17/21.
//

import Foundation

class User {
        var id: String
        var username: String
        var contact: String
        var location: String
        var displayName: String?
    
    init(details: [String: Any]) {
        id = details["id"] as? String ?? ""
        username = details["username"] as? String ?? ""
        contact = details["contactInfo"] as? String ?? ""
        location = details["location"] as? String ?? ""
        displayName = details["displayName"] as? String
    }
}
