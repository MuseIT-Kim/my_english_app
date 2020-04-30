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
        db.collection("words").whereField("completefg", isEqualTo: 0).getDocuments{(Snapshot,err) in
            
            
            if err != nil {
                
                print(err)
                
            }
            
                for document in (Snapshot?.documents)!{
                    
                    if let readfg = document.data()["readfg"] as? Int {
                        
                        switch readfg {
                        case 0:
                           if let english = document.data()["english"] as? String{
                                 
                                 self.englishWord.text = english
                             }
                             if let japanese = document.data()["japanese"] as? String{
                                 
                                 self.japanese.text = japanese
                            }
                            
                           
                        default:
                            break
                            }
                        }
                        
                    }
            
                }
            }
        }
        
    
    




