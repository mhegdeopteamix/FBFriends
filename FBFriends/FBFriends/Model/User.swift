//
//  User.swift
//  FBFriends
//
//  Created by Mahabaleshwar Hegde on 11/04/17.
//  Copyright © 2017 Mahabaleshwar Hegde. All rights reserved.
//

import Foundation

struct User: ProfileDisplayable {
    
    var name: String?
    var profilePicURL: String?
    var friendsNextPages: FriendPagination?
    var friends: [Friends] = []
    var email : String?
    var id: String?
    var firstName: String?
    var lastName: String?
    
    init(name: String, profilePicURL: String, email: String, firstName: String, lastName: String) {
        self.profilePicURL = profilePicURL
        self.name = name
        self.email = email
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
        if let value = dictionary["taggable_friends"] as? [String : Any] {
            if let list = value["data"] as? [[String: Any]] {
                 self.parseFriends(list: list)
            }
            if let page = value["paging"] as? [String : Any] {
                self.parsePagination(info: page)
            }
        }
    }
    
    mutating func parseFriends(list : [[String : Any]]) {
        
        for friend in list {
            let friend = Friends(dictionary: friend)
            self.friends.append(friend)
        }
    }
    
    mutating func parsePagination(info: [String: Any]) {
        
        self.friendsNextPages = FriendPagination(dictionary: info)
    }
}
