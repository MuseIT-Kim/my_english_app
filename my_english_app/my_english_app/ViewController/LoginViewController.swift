//
//  LoginViewController.swift
//  my_english_app
//
//  Created by 金相恩 on 2020/04/20.
//  Copyright © 2020 Kim. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        emailTextField.layer.borderColor = UIColor(red: 0.1, green: 0.7, blue: 0.9, alpha: 1.0).cgColor
        emailTextField.layer.borderWidth = 1.0
        
        passwordTextField.layer.borderColor = UIColor(red: 0.1, green: 0.7, blue: 0.9, alpha: 1.0).cgColor
        passwordTextField.layer.borderWidth = 1.0
        
    }
    

    
    @IBAction func loginTapped(_ sender: Any) {
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        Auth.auth().signIn(withEmail: email, password: password ){
            
            (result, error) in
            
            if error != nil {
                //ログイン失敗
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
                
            }
            
            else {
                let homeViewController =
                    self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
                 
            }
        }
        
    }
    
    
}
