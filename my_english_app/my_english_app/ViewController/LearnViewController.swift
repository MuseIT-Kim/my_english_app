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
    
    @IBOutlet weak var japanese: UILabel!
    @IBOutlet weak var englishWord: UILabel!
    /*override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated:true)
    }*/
    
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    var path:String = "";
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
                let data1 = document.data()
                let data2 = data1["1"]
                
                print(data2)
                let data3:[String:AnyObject] = data2 as! [String : AnyObject]
                let engWd : NSString? = data3["eng"]! as? NSString
                let jpnWd : NSString? = data3["jpn"]! as? NSString
                //let path_: NSString? = data3["voice"]! as? NSString
                self.path = engWd as! String
                self.englishWord.text = engWd as? String
                self.japanese.text = jpnWd as? String
            
            
            }
            
                }
            }
    
    //let voicePath = Bundle.main.bundleURL.appendingPathComponent("apple.mp3")
    
    @IBAction func tappedVoiceButton(_ sender: Any) {
        
        var _:AVAudioPlayer = AVAudioPlayer()
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        //let storageRef = storage.reference(forURL: "gs://my-english-app-f5a20.appspot.com")
        
        
        
        // Create a child reference
        // imagesRef now points to "images"
        let voiceRef = storageRef.child("wordList/"+path+".mp3")
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(path+".mp3")
        
        //let storagePath = "\gs://my-english-app-f5a20.appspot.com/wordList/space.jpg"
        //spaceRef = storage.reference(forURL: storagePath)
        //gs://my-english-app-f5a20.appspot.com/wordList/apple.mp3
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
    
    
    
        }

