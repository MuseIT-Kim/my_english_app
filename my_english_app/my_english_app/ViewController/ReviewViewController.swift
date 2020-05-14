//
//  ReviewViewController.swift
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
import AVFoundation
import FirebaseStorage

class ReviewViewController: UIViewController {

    @IBOutlet weak var reEnglishWord: UILabel!
    
    @IBOutlet weak var reJapaneseWord: UILabel!
    
    @IBOutlet weak var reBackButton: UIButton!
    
    @IBOutlet weak var reDoneButton: UIButton!
    @IBOutlet weak var reUncompletedButton: UIButton!
    
    @IBOutlet weak var reVoiceButton: UIButton!
    @IBOutlet weak var reReadfg: UILabel!
    
    
    @IBOutlet weak var reButtons: UIStackView!
    
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    var path:String = "";
    var a_ = Int();
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        reBackButton.isHidden = true
        reButtons.isHidden = true
        reVoiceButton.isHidden = true
        
        let db = Firestore.firestore()
            
            let userID = Auth.auth().currentUser?.uid
            
            if let user = userID{
                print("userID:" + user)
                a_ = 0;
                //newWords2(a: a_)
                newWords(a: a_)
            }
        }
       
      
    func newWords(a:Int)->Any {
    
        let db = Firestore.firestore()
               
        let userID = Auth.auth().currentUser?.uid
        
        
        db.collection("words").whereField("uid", isEqualTo: userID).getDocuments{(Snapshot,err) in

            //let ref = db.collection("words").document(userID)
        
           
        
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
                    self.reEnglishWord.text = "new単語がありません"
                    self.reJapaneseWord.text = ""
                    self.reBackButton.isHidden = false
                    self.reVoiceButton.isHidden = true
                    
                    break;
                }
                
                print(data2)
                let data3:[String:AnyObject] = data2 as! [String : AnyObject]
                let check : NSString? = data3["readfg"]! as? NSString
                
                if check == "1"{
                
                let engWd : NSString? = data3["eng"]! as? NSString
                let jpnWd : NSString? = data3["jpn"]! as? NSString
                let readFg : NSString? = data3["readfg"]! as? NSString
                   
                    //let path_: NSString? = data3["voice"]! as? NSString
                self.path = engWd as! String
                self.reEnglishWord.text = engWd as? String
                self.reJapaneseWord.text = jpnWd as? String
                    Utilities.styleHollowButton(self.reDoneButton)
                    Utilities.styleFilledButton(self.reUncompletedButton)
                   
                    //db.collection("words").document(userID!).updateData([indexStr+".readfg":"1"])
                    self.a_ += 1;
                  //print(data2)
                    
                }
                
                else if check == "0" {
                    
                    self.a_ += 1;
                    self.newWords(a: self.a_)
                }
            
            }
            
                }
        //a_ += 1;
        return a_
    }
    
    @IBAction func reTappedVoiceButton(_ sender: Any) {
    
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
    
    /*@IBAction func tappedOk(_ sender: Any) {
        
        newWords(a: a_)
        
    }*/
    
    
    @IBAction func tappedReDoneButton(_ sender: Any) {
        newWords(a: a_)
    }
    
    
    @IBAction func tappedReUncompletedButton(_ sender: Any) {
        
        
    }
    
    
    @IBAction func tappedReHome(_ sender: Any) {
        transitionToHome()
    }
    
    
    
    func transitionToHome(){
        
        let homeViewController =
        storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
        
    
    
    }

}
