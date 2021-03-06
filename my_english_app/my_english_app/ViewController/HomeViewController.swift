//
//  HomeViewController.swift
//  my_english_app
//
//  Created by 金相恩 on 2020/04/20.
//  Copyright © 2020 Kim. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var LearnViewButton: UIButton!
    @IBOutlet weak var ReviewViewButton: UIButton!
    @IBOutlet weak var ReviewViewAllButton: UIButton!
    @IBOutlet weak var TestButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewDidLoad() {
       
        super.viewDidLoad()
    }
    
    @IBAction func LearnViewTapped(_ sender: Any) {
        
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "LearnView")
        
        vcName?.modalTransitionStyle = .coverVertical
        self.present(vcName! , animated: true, completion: nil)
    }
    @IBAction func ReviewViewButtonTapped(_ sender: Any) {
     
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "ReviewView")
        
        vcName?.modalTransitionStyle = .coverVertical
        self.present(vcName! , animated: true, completion: nil)
    }
    


    @IBAction func AllviewViewButtonTapped(_ sender: Any) {
        
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "AllviewView")
        
        vcName?.modalTransitionStyle = .coverVertical
        self.present(vcName! , animated: true, completion: nil)
        
    }
    

    @IBAction func TestViewButtonTapped(_ sender: Any) {
        
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "TestView")
        
        vcName?.modalTransitionStyle = .coverVertical
        self.present(vcName! , animated: true, completion: nil)
        
    }
    
}
