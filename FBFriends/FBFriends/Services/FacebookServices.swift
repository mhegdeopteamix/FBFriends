//
//  FacebookServices.swift
//  FBFriends
//
//  Created by Mahabaleshwar Hegde on 11/04/17.
//  Copyright © 2017 Mahabaleshwar Hegde. All rights reserved.
//

import Foundation
import FBSDKCoreKit

enum Result<T> {
    case success(T)
    case failed(String, Error)
}


struct FacebookServices {
    
    static let shared = FacebookServices()
    private init() {
        
    }
    
    func sendGraphRequest(params: [String: Any], completionHandler: @escaping (Result<User>) -> Void) {
        
        let _ = FBSDKGraphRequest(graphPath: "me", parameters: params).start { connection, response, error in
            
            if connection?.urlResponse.statusCode == 200 {
                
                print("\(response)")
                let user = User(dictionary: response as! [String: Any])
                completionHandler(Result.success(user))
                
            } else {
                completionHandler(.failed("Not able to fetch", error!))
            }
        }
    }
}
