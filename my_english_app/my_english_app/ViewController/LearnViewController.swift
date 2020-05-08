//
//  LearnViewController.swift
//  my_english_app
//
//  Created by 金相恩 on 2020/04/27.
//  Copyright © 2020 Kim. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase
import FirebaseCore
import FirebaseFirestore


class LearnViewController: UIViewController {
    
    @IBOutlet weak var japanese: UILabel!
    @IBOutlet weak var englishWord: UILabel!
    /*override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated:true)
    }*/
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.uid
        
        if let user = userID{
            print("userID:" + user)
            
        }
            
        
        db.collection("words").whereField("uid", isEqualTo: userID).getDocuments{(Snapshot,err) in
            
            if err != nil {
                print(err)
                }
            
            for document in (Snapshot?.documents)!{
                
                print(document.data())
                if let eng = document.get("uid"){
                    
                    self.englishWord.text = eng as! String
                }
               
                    }
                }
            }
        }
