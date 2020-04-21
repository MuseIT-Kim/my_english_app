//
//  SignUpViewController.swift
//  my_english_app
//
//  Created by 金相恩 on 2020/04/20.
//  Copyright © 2020 Kim. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseCore
import FirebaseFirestore

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var FirstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirstNameTextField.layer.borderColor = UIColor(red: 0.1, green: 0.7, blue: 0.9, alpha: 1.0).cgColor
        FirstNameTextField.layer.borderWidth = 1.0
        
        lastNameTextField.layer.borderColor = UIColor(red: 0.1, green: 0.7, blue: 0.9, alpha: 1.0).cgColor
        lastNameTextField.layer.borderWidth = 1.0
        
        emailTextField.layer.borderColor = UIColor(red: 0.1, green: 0.7, blue: 0.9, alpha: 1.0).cgColor
        emailTextField.layer.borderWidth = 1.0
        
        passwordTextField.layer.borderColor = UIColor(red: 0.1, green: 0.7, blue: 0.9, alpha: 1.0).cgColor
        passwordTextField.layer.borderWidth = 1.0
    }
    
    //sign up fields check
    func validateFields() -> String? {
        //空欄がある場合
        if FirstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            {
            return "Pleas fill in all fields."
        }
        
        //emailが有効かチェック
        let cleanedEmail = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isValidEmail(cleanedEmail) == false {
            
            return "正しいメールアドレスを入力してください。"
        }
        
        //パスワードが有効かチェック
        let cleanedPassword = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isValidPassword(cleanedPassword) == false {
            
            return "パスワードは、「英字の大文字」「英字の小文字」「数字」組み合わせて、8文字以上にしてください。"
        }
        
        return nil
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        //fieldsチェック
        let error = validateFields()
        
        if error != nil {
            
            //fieldsに何か問題があった場合エラーメッセージを表示
            showError(error!)
        }
        else{
            
            let firstName = FirstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //createユーザ
            Auth.auth().createUser(withEmail: email, password: password) { (result,err) in
                
                if err != nil {
                    //user登録に問題があった場合
                    self.showError("Error creating user")
                }
                else{
                    //user登録成功
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname": firstName, "lastName": lastName, "uid": result!.user.uid]) {(error) in
                        if error != nil {
                            
                            self.showError("登録できませんでした。")
                            
                        }
                        
                    }
                 //home screenへ
                    self.transitionToHome()
                
                }
                
            }
            
        }
        
    }
    
    func showError(_ message : String){
        
        errorLabel.text = message
        errorLabel.alpha = 1
        
    }
    
    func transitionToHome(){
        
        let homeViewController =
        storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
        
    }
    
}
