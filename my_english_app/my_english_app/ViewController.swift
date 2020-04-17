//
//  ViewController.swift
//  my_english_app
//
//  Created by 金相恩 on 2020/04/16.
//  Copyright © 2020 Kim. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputEmail: UITextField!
        {
        
        didSet{
            guard let field = self.inputEmail else { return }
            field.placeholder = "Enter your email here"
            
        }
        
    }
       
    @IBOutlet weak var inputPassword: UITextField!
        {
            
            didSet{
                guard let field = self.inputPassword else { return }
                field.placeholder = "Enter your password"
                field.isSecureTextEntry = true
            }
            
        }
    
    
    @IBOutlet weak var loginButton: UIButton!{
        
        didSet{
            guard let button = self.loginButton else { return }
            button.setTitle("Login", for: .normal)
            
                   }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Text Fieldのdelegate通知先を設定
        inputEmail.delegate = self
        //inputEmail.layer.borderColor = UIColor(red: 38/255, green: 153/255, blue: 251/255, alpha: 1).cgColor
        configureUI()
    }
    func configureUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles=true
        navigationItem.title = "Login"
        navigationController?.navigationBar.barTintColor = UIColor(red: 38/255, green: 153/255, blue: 251/255, alpha: 1)
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        //UINavigationBar.appearance().tintColor = UIColor.white
        //UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    
        }
       
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //キーボードを閉じる
        textField.resignFirstResponder()
        
        //入力された文字を取り出す
        if let input_email = textField.text{
            //入力された文字をデバッグエリアに表示
            print(input_email)
        }
       return true
    
    }
    
}

