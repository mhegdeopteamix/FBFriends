//
//  FriendsDisplayable.swift
//  FBFriends
//
//  Created by Mahabaleshwar Hegde on 11/04/17.
//  Copyright © 2017 Mahabaleshwar Hegde. All rights reserved.
//

import Foundation
import UIKit


protocol  ProfileDisplayable: CustomURLConvertible {
    var name : String? { get set }
    var profilePicURL: String? { get set }
    var id: String? { get set }
    var firstName: String? { get set }
    var lastName: String? { get set }
}

protocol CustomURLConvertible {
    var convertedURL: URL? { get }
}

extension ProfileDisplayable {
    var convertedURL: URL? {
        get {
            guard let profilePicURL = self.profilePicURL else { return nil }
            return URL(string: profilePicURL)
        }
    }
}

protocol CircularImageRepresenatable {
    func circular()
}

protocol ImageFetchable {
    func loadImage(fromURL url: URL, placeholder: UIImage)
}

extension UIImageView: CircularImageRepresenatable {}

extension CircularImageRepresenatable where Self: UIImageView {
    
    func circular() {
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width / 2.0
        self.layoutIfNeeded()
    }
}

extension UIImageView: ImageFetchable { }

extension ImageFetchable where Self: UIImageView {
    
    func loadImage(fromURL url: URL, placeholder: UIImage) {
        
        do {
            let imageData = try Data(contentsOf: url)
            if let image = UIImage(data: imageData) {
                self.image = image
            } else {
                self.image = placeholder
            }
            
            
        } catch  {
            self.image = placeholder
        }
    }
}
