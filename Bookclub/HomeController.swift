//
//  HomeController.swift
//  Bookclub
//
//  Created by Amina Mazhar on 6/25/19.
//  Copyright © 2019 Amina Mazhar. All rights reserved.
//

import Foundation
import UIKit
import FirebaseUI
import Firebase

class HomeController: UIViewController {

    @IBOutlet weak var welcome: UILabel!
    
    @IBAction func signOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.performSegue(withIdentifier: "login", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func viewDidLoad() {
        let user = Auth.auth().currentUser
        var name = "Welcome back "
        if let user = user {
            if let name2 = user.displayName {
                name += name2
            }
        }
        name += "!"
        welcome.text = name
        welcome.font = UIFont(name: "Bahuraksa", size: 22)
        welcome.numberOfLines = 0
        welcome.sizeToFit()
        welcome.lineBreakMode = NSLineBreakMode.byWordWrapping
        //view.backgroundColor = UIColor.cyan
    }
}
