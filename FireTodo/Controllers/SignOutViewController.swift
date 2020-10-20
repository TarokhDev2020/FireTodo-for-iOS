//
//  SignOutViewController.swift
//  FireTodo
//
//  Created by Tarokh on 10/4/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit
import Firebase

class SignOutViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var signOutButton: RoundButton!
    
    
    //MARK: - Variables
    
    //MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {return}
        emailLabel.text = email
    }
    
    //MARK: - Functions
    @IBAction func signOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            if self.presentationController != nil {
                self.dismiss(animated: true) {
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                }
            }
            else {
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            }
        }
        catch {
            print("Already logged out")
        }
    }
    

}
