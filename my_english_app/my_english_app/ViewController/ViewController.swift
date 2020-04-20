//
//  ViewController.swift
//  my_english_app
//
//  Created by 金相恩 on 2020/04/16.
//  Copyright © 2020 Kim. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
     
    }
    
    
    func setUpElements() {
        
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
        
    }

    
}

