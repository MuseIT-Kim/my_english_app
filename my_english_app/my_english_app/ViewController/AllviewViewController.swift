//
//  AllviewViewController.swift
//  my_english_app
//
//  Created by 金相恩 on 2020/05/18.
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

class AllviewViewController: UIViewController{
    
    
    @IBOutlet weak var AllviewVoiceButton: UIButton!
    
    @IBOutlet weak var AllviewBack: UIButton!
    
    
    @IBOutlet weak var AllviewEnglishWords: UILabel!
    
    @IBOutlet weak var AllviewJapaneseWords: UILabel!
    

    @IBOutlet weak var AllviewDone: UIButton!
    

    @IBOutlet weak var AllviewUncompleted: UIButton!
    
    @IBOutlet weak var AllviewButtons: UIStackView!

    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    var path : String = "";
    var AllviewWordListIndex = Int();

    override func viewDidLoad() {
        
        super.viewDidLoad()
        AllviewBack.isHidden = true
        AllviewButtons.isHidden = true
        AllviewVoiceButton.isHidden = true
        Utilities.styleHollowButton(AllviewDone)
        Utilities.styleFilledButton(AllviewUncompleted)
        
        let db = Firestore.firestore()
        
        let userID = Auth.auth().currentUser?.uid
        
        if let user = userID{
            print("userID:" + user)
            AllviewWordListIndex = 0;
            AllNewWords(a: AllviewWordListIndex)
            //newWords2(a: a_)
            //newWords(a: wordListIndex)
        }
    }
    
    func AllNewWords(a:Int)->Any {

            let db = Firestore.firestore()
            let userID = Auth.auth().currentUser?.uid
            db.collection("words").whereField("uid", isEqualTo: userID).getDocuments{(Snapshot,err) in

                let index_ = a;
                if err != nil {
                    print(err)
                    }
                for document in (Snapshot?.documents)!{
                    let indexStr = index_.description
                    print(document.data())
                    let data1 = document.data()
                    let data2 = data1[indexStr]
                    
                    if data2 == nil {
                        self.AllviewEnglishWords.text = "new単語がありません"
                        self.AllviewJapaneseWords.text = ""
                        self.AllviewBack.isHidden = false
                        self.AllviewVoiceButton.isHidden = true
                        self.AllviewButtons.isHidden = true
                        break;
                    }
                    
                    print(data2)
                    let data3:[String:AnyObject] = data2 as! [String : AnyObject]
                    //let check : NSString? = data3["readfg"]! as? NSString
                    
                    
                    
                    let engWd : NSString? = data3["eng"]! as? NSString
                    let jpnWd : NSString? = data3["jpn"]! as? NSString
                    let readFg : NSString? = data3["readfg"]! as? NSString
                    
                    self.path = engWd as! String
                    self.AllviewEnglishWords.text = engWd as? String
                    self.AllviewJapaneseWords.text = jpnWd as? String
                    self.AllviewVoiceButton.isHidden = false
                    self.AllviewButtons.isHidden = false
                        self.AllviewWordListIndex += 1;
                   
                    
                }
            }
           return AllviewWordListIndex
        }
        
    

    
@IBAction func AllviewVoiceTapped(_ sender: Any) {
        var _:AVAudioPlayer = AVAudioPlayer()
              
              let storage = Storage.storage()
              let storageRef = storage.reference()
        
              let voiceRef = storageRef.child("wordList/"+path+".mp3")
              
              let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(path+".mp3")
             
              voiceRef.getData(maxSize: 10 * 1024 * 1024) { (data, error) in
                  if let error = error {
                      print(error)
                  } else {
                      if let d = data {
                          do {
                              try d.write(to: fileURL)
                              self.audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
                              self.audioPlayer.play()
                          } catch {
                              print(error)
                          }
                      }
                  }
              }
        
    }
    

    @IBAction func AllviewBack(_ sender: Any) {
    
    transitionToHome()
    }
    
    
    func transitionToHome(){
        let homeViewController =
        storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    

    
}


