//
//  TestviewViewController.swift
//  my_english_app
//
//  Created by 金相恩 on 2020/05/20.
//  Copyright © 2020 Kim. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import UIKit
import FirebaseAuth
import Firebase
import FirebaseCore
import FirebaseFirestore
import AVFoundation
import FirebaseStorage

class TestviewViewController : UIViewController {
    
    @IBOutlet weak var englishWord: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let db = Firestore.firestore()
               let userID = Auth.auth().currentUser?.uid
               if let user = userID{
                   print("userID:" + user)
                
                }
                
                
    }
    
    
    
}
