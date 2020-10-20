//
//  ViewController.swift
//  FireTodo
//
//  Created by Tarokh on 10/4/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase
import Loaf
import JGProgressHUD

class AuthenticationViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet var authSegmentedControl: UISegmentedControl!
    @IBOutlet var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet var authButton: RoundButton!
    
    
    //MARK: - Variables
    var hud: JGProgressHUD?
    var window: UIWindow?
    
    
    //MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authButton.setTitle("Register", for: .normal)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGestureRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGestureRecognizer)
        
        emailTextField.delegate = self
        emailTextField.tag = 0
        passwordTextField.delegate = self
        passwordTextField.tag = 1
    }
    
    //MARK: - Functions
    @IBAction func authButtonTapped(_ sender: Any) {
        hud = JGProgressHUD(style: .dark)
        hud?.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        hud?.show(in: self.view, animated: true)
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        UserDefaults.standard.set(email, forKey: "email")
        if authSegmentedControl.selectedSegmentIndex == 0 {
            self.register(email, password)
        }
        else {
            self.login(email, password)
        }
    }
    
    @IBAction func authSegmentedChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            authButton.setTitle("Register", for: .normal)
        }
        else {
            authButton.setTitle("Login", for: .normal)
        }
    }
    
    private func login(_ email: String, _ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if err == nil {
                self.hud?.dismiss(animated: true)
                self.performSegue(withIdentifier: "goToTasks", sender: self)
            }
            else {
                self.hud?.indicatorView = JGProgressHUDErrorIndicatorView()
                self.hud?.show(in: self.view, animated: true)
                self.hud?.dismiss(afterDelay: 1.5)
                
            }
        }
    }
    
    private func register(_ email: String, _ password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            if err == nil {
                self.hud?.dismiss(animated: true)
                self.performSegue(withIdentifier: "goToTasks", sender: self)
            }
            else {
                self.hud?.indicatorView = JGProgressHUDErrorIndicatorView()
                self.hud?.show(in: self.view, animated: true)
                self.hud?.dismiss(afterDelay: 1.5)
            }
        }
    }
    
    @objc private func dismissKeyboard() {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
    
}

//MARK: - UITextFieldDelegate
extension AuthenticationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
}

