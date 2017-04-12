//
//  ViewController.swift
//  FBFriends
//
//  Created by Mahabaleshwar Hegde on 11/04/17.
//  Copyright © 2017 Mahabaleshwar Hegde. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var user = User() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("friends count is \(self.user?.friends.count)")
        return self.user?.friends.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Friends", for: indexPath)
        if indexPath.row == (self.user?.friends.count)! - 3, let _ = user?.friendsNextPages?.after  {
            fetchProfile()
        }
        return cell
        
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.imageView?.circular()
        let friend = self.user?.friends[indexPath.row]
        cell.textLabel?.text = friend?.name
        cell.detailTextLabel?.text = nil
//        if let url = friend?.convertedURL {
//            cell.imageView?.loadImage(fromURL: url, placeholder: #imageLiteral(resourceName: "ic_avatar"))
//        } else {
//            cell.imageView?.image = #imageLiteral(resourceName: "ic_avatar")
//        }
        
    }
}

extension ViewController  {
    
    func fetchProfile() {
        
        //let meParams = "id, name, picture.width(200).height(200), gender, first_name, last_name, link, birthday, hometown, location"
        var friendsParams = "taggable_friends"
        
        //var defaultParams = "id, first_name, last_name, middle_name, name, email, picture, ?limit(10)"
        if let nextPageCursor = user?.friendsNextPages?.after {
            friendsParams += ".limit(10)" + ".after(" + nextPageCursor + ")"
        } else {
            self.user?.friends.removeAll()
        }
        let requiredParams = friendsParams + "{id, email, name, first_name, last_name, picture.width(200).height(200), gender, birthday, link}"
        let params = ["fields": requiredParams]
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        FacebookServices.shared.sendGraphRequest(params: params) { result in
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch result {
                case .success(let user):
                    self.user = user
                case .failed(let messge, let error):
                    print("\(messge), \(error)")
                }
            }
        }
        
    }
}
