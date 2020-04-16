//
//  ViewController.swift
//  my_english_app
//
//  Created by 金相恩 on 2020/04/16.
//  Copyright © 2020 Kim. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Text Fieldのdelegate通知先を設定
        inputEmail.delegate = self
        
        //configureUI()
    }
    /*func configureUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles=true
        navigationItem.title = "Login"
        navigationController?.navigationBar.barTintColor = UIColor(red: 38/255, green: 153/255, blue: 251/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
       
    }*/
    
    @IBOutlet weak var inputEmail: UITextField!
    
    @IBOutlet weak var inputPassword: UITextField!
    
    
    func inputEmailShouldReturn(_ textField: UITextField) -> Bool {
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

