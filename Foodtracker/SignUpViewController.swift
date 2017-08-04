//
//  SignUpViewController.swift
//  Foodtracker
//
//  Created by Alex Wymer  on 2017-08-01.
//  Copyright © 2017 Sav Inc. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let warningAlert = UIAlertController(title: "Invalid", message: "Username or Password is invalid \n Password must be at least 8 characters long", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    

    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        warningAlert.addAction(okAction)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    //MARK: Actions
    @IBAction func signUpTapped(_ sender: UIButton) {
        
        guard let userName = usernameTextField.text, userName != "", let pass = passwordTextField.text, pass != ""  else {
            self.present(warningAlert, animated: true, completion: nil)
            return
        }
        
//         guard ((passwordTextField.text!.characters.count) as Int) > 8 else {
//         self.present(warningAlert, animated: true, completion: nil)
//         return
//         }
    
        NetworkManager.requestPost(path: "/signup", with: [userName, pass]) {( data: [String : Any]) in
        
            guard let authToken = data["token"] as? String else {
                
                // some problem
                return
            }
            
            // save to user defaults
            UserDefaults.standard.setValue(authToken, forKey: "user_auth_token")
            print(authToken)
        }
        
        self.performSegue(withIdentifier: "gotIn", sender: nil)
    }
    
    @IBAction func logInTapped(_ sender: UIButton) {
        
        guard let userName = usernameTextField.text, userName != "", let pass = passwordTextField.text, pass != ""  else {
            self.present(warningAlert, animated: true, completion: nil)
            return
        }

        
        NetworkManager.requestPost(path: "/login", with: [userName, pass]) { (data: [String : Any]) in
            
            guard let authToken = data["token"] as? String else {
                
                // some problem
                return
            }
            
            // save to user defaults
            UserDefaults.standard.setValue(authToken, forKey: "userAuthToken")
            print("\(UserDefaults.standard.value(forKey: "userAuthToken")!)")
        }
        self.performSegue(withIdentifier: "gotIn", sender: nil)
    }
    
    
}
