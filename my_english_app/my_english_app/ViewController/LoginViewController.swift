//
//  LoginViewController.swift
//  my_english_app
//
//  Created by 金相恩 on 2020/04/20.
//  Copyright © 2020 Kim. All rights reserved.
//

import UIKit

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
    }
    
    
}
