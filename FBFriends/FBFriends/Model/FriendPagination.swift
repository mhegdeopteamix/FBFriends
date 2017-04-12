//
//  FriendPagination.swift
//  FBFriends
//
//  Created by Mahabaleshwar Hegde on 11/04/17.
//  Copyright © 2017 Mahabaleshwar Hegde. All rights reserved.
//

import Foundation

struct FriendPagination {
    
    var before: String?
    var after: String?
    var nextURL: String?
    var previousURL: String?
    
    init(dictionary: [String: Any]) {
        
        if let cursors = dictionary["cursors"] as? [String: Any] {
            self.before = cursors["before"] as? String
            self.after = cursors["after"] as? String
        }
        
        if let value = dictionary["next"] as? String {
            self.nextURL = value
        }
        if let value = dictionary["previous"] as? String {
            self.previousURL = value
        }
    }
}

extension String: CustomURLConvertible {
    
    var convertedURL: URL? {
        return URL(string: self)
    }
}
