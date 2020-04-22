//
//  SignUpViewController.swift
//  my_english_app
//
//  Created by 金相恩 on 2020/04/20.
//  Copyright © 2020 Kim. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor(red: 0.6, green: 0.3, blue: 0.3, alpha: 1.0).cgColor
        
        bottomLine.borderWidth = 3.0
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
 
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 25/255, green: 178/255, blue: 251/255, alpha: 1)
        //UIColor(red: 0.1, green: 0.7, blue: 0.9, alpha: 1.0).cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0.1, green: 0.7, blue: 0.9, alpha: 1.0).cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    

    static func isValidEmail(_ email : String?) -> Bool {
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    
    static func isValidPassword(_ password : String?) -> Bool {
        //passwordチェック
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: password)
    }
    
}
