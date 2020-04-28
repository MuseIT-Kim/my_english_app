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
        db.collection("words").whereField("id", isEqualTo: 1).getDocuments{(Snapshot,err) in
            if err != nil {
                
                print(err)
                
            }else {
                
                for document in (Snapshot?.documents)!{
                    
                    if let english = document.data()["english"] as? String{
                        print(english)
                        self.englishWord.text = english
                     
                    }
                    
                    if let japanese = document.data()["japanese"] as? String{
                    print(japanese)
                        self.japanese.text = japanese
                        
                        
                        
                    }
                    
                    
                    
                    
                }
            }
        }
        
    }
    


}

