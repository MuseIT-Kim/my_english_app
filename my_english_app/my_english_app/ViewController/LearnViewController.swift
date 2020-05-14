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
import AVFoundation
import FirebaseStorage


class LearnViewController: UIViewController {
    
    
    @IBOutlet weak var englishWord: UILabel!
    
    @IBOutlet weak var japanesWord: UILabel!
    
    @IBOutlet weak var voiceButton: UIButton!
    
    @IBOutlet weak var buttons: UIStackView!
    @IBOutlet weak var doneButton: UIButton!
    
    
    @IBOutlet weak var uncompletedButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    /*override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated:true)
    }*/
    
    //var ref:DatabaseReference!
    //var ref = Database.database().reference()
    
    @IBOutlet weak var readfg: UILabel!
    
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    var path:String = "";
    var a_ = Int();

    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        backButton.isHidden = true
        buttons.isHidden = true
        voiceButton.isHidden = true
        //Utilities.styleHollowButton(doneButton)
        //Utilities.styleFilledButton(uncompletedButton)
        
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
                    self.englishWord.text = "new単語がありません"
                    self.japanesWord.text = ""
                    self.backButton.isHidden = false
                    self.voiceButton.isHidden = true
                    
                    break;
                }
                
                print(data2)
                let data3:[String:AnyObject] = data2 as! [String : AnyObject]
                let check : NSString? = data3["readfg"]! as? NSString
                
                if check == "0"{
                
                let engWd : NSString? = data3["eng"]! as? NSString
                let jpnWd : NSString? = data3["jpn"]! as? NSString
                let readFg : NSString? = data3["readfg"]! as? NSString
                   
                    //let path_: NSString? = data3["voice"]! as? NSString
                self.path = engWd as! String
                self.englishWord.text = engWd as? String
                self.japanesWord.text = jpnWd as? String
                    Utilities.styleHollowButton(self.doneButton)
                    Utilities.styleFilledButton(self.uncompletedButton)
                   
                    db.collection("words").document(userID!).updateData([indexStr+".readfg":"1"])
                    self.a_ += 1;
                  //print(data2)
                    
                }
                
                else if check == "1" {
                    
                    self.a_ += 1;
                    self.newWords(a: self.a_)
                }
            
            }
            
                }
        //a_ += 1;
        return a_
    }
    
    func newWords2(a:Int)->Any {
    
        let db = Firestore.firestore()
               
        //let userID = Auth.auth().currentUser?.uid
        
        
        db.collection("words").whereField("new", isEqualTo: "0").getDocuments{(Snapshot,err) in
            let index_ = a;
            if err != nil {
                print(err)
                }
            for document in (Snapshot?.documents)!{
                let indexStr = index_.description
                print(document.data())
                let data1 = document.data()
                let data2 = data1[indexStr]
                
                print(data2)
                var data3:[String:AnyObject] = data2 as! [String : AnyObject]
                let check : NSString? = data3["readfg"]! as? NSString
                
                if check == "0"{
                
                let engWd : NSString? = data3["eng"]! as? NSString
                let jpnWd : NSString? = data3["jpn"]! as? NSString
                let readFg : NSString? = data3["readfg"]! as? NSString
                   
                    //let path_: NSString? = data3["voice"]! as? NSString
                self.path = engWd as! String
                self.englishWord.text = engWd as? String
                self.japanesWord.text = jpnWd as? String
                  
                    
                    
                  print(data2)
                    
                }
           else {
                    
                }
            
            }
                }
        a_ += 1;
        return a_
    }
    
    @IBAction func tappedVoiceButton(_ sender: Any) {
        
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
    
    @IBAction func tappedOk(_ sender: Any) {
        
        newWords(a: a_)
        
    }
    
    @IBAction func tappedHomeButton_(_ sender: Any) {
        transitionToHome()
    }
    
    
    func transitionToHome(){
        
        let homeViewController =
        storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
        
    }
    
}

