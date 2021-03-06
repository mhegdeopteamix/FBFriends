//
//  Friends.swift
//  FBFriends
//
//  Created by Mahabaleshwar Hegde on 11/04/17.
//  Copyright © 2017 Mahabaleshwar Hegde. All rights reserved.
//

import Foundation


struct Friends: ProfileDisplayable {
    
    var name: String?
    var profilePicURL: String?
    var id: String?
    var firstName: String?
    var lastName: String?
    
    
    init(name: String, profilePicURL: String, tagId: String, firstName: String, lastName: String) {
        self.profilePicURL = profilePicURL
        self.name = name
        self.id = tagId
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init?() {
        
    }
    
    init(dictionary: [String: Any]) {
        
        if let value = dictionary["first_name"] as? String {
            self.firstName = value
        }
        if let value = dictionary["last_name"] as? String {
            self.lastName = value
        }
        if let value = dictionary["name"] as? String {
            self.name = value
        }
        if let value = dictionary["id"] as? String {
            self.id = value
        }
        if let value = dictionary["picture"] as? [String: Any], let picture = value["data"] as? [String: Any] {
            if let value = picture["url"] as? String {
                self.profilePicURL = value
            }
        }
    }
}

