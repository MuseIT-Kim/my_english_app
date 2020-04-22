//
//  ViewController.swift
//  my_english_app
//
//  Created by 金相恩 on 2020/04/16.
//  Copyright © 2020 Kim. All rights reserved.
//

import UIKit
import AVKit


class ViewController: UIViewController, UITextFieldDelegate {

    var videoPlayer:AVPlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        setUpVideo()
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
     
    }
    
   
    func setUpElements() {
        
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
        
    }
    
    func setUpVideo() {
        
        let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
        
        guard bundlePath != nil else {
            return
        }
        
        let url = URL(fileURLWithPath: bundlePath!)
        
        let item = AVPlayerItem(url: url)
        
        videoPlayer = AVPlayer(playerItem: item)
        
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        videoPlayer?.playImmediately(atRate: 0.3)
    }

    
}

