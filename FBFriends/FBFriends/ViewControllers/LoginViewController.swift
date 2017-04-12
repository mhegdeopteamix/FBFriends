//
//  LoginViewController.swift
//  FBFriends
//
//  Created by Mahabaleshwar Hegde on 11/04/17.
//  Copyright © 2017 Mahabaleshwar Hegde. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let friendsVC = segue.destination as! ViewController
        friendsVC.user = sender as? User
    }
    

}

// MARK: - FBSDKLoginButtonDelegate

extension LoginViewController: FBSDKLoginButtonDelegate {
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logout")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            print("error")
        } else {
            if let _ = result.token {
                let meParams = "id, name, picture.width(200).height(200), gender, first_name, last_name, link, birthday, hometown, location"
                let friendsParams = "taggable_friends{id, email, name, first_name, last_name, picture.width(200).height(200), gender, birthday, link}"
                let params = ["fields": meParams + ", " + friendsParams]
                
                FacebookServices.shared.sendGraphRequest(params: params, completionHandler: { response in
                   
                    DispatchQueue.main.async {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                    
                    switch response {
                    case .success(let user):
                           self.performSegue(withIdentifier: "LoginViewController", sender: user)
                    case  .failed(let message, let error):
                          print("message is \(message), error is \(error.localizedDescription)")
                    }
                })
            }
        }
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        return true
    }
}


