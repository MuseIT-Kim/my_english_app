//
//  TestViewController.swift
//  my_english_app
//
//  Created by 金相恩 on 2020/05/27.
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

class TestViewController : UIViewController{
    
    
    @IBOutlet weak var TestEnglishWord: UILabel!
    @IBOutlet weak var TestAnswer_1: UIButton!
    @IBOutlet weak var TestAnswer_2: UIButton!
    @IBOutlet weak var TestAnswer_3: UIButton!
    @IBOutlet weak var TestAnswer_4: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    
    var TestviewWordListIndex = Int();
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.uid
        
        TestviewWordListIndex = 0;
        TestNewWords(a: TestviewWordListIndex)
    
    }
    
    func TestNewWords(a:Int)->Any {

    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    db.collection("words").whereField("uid", isEqualTo: userID).getDocuments{(Snapshot,err) in

        let index_ = a;
        var answerArr = [Any](repeating:"None",count:3)
        
        if err != nil {
            print(err)
            }
        for document in (Snapshot?.documents)!{
            let numbers: [String]
            let indexStr = index_.description
            print(document.data())
            
            let data1 = document.data()
            //data[0] 즉indexStr=0 apple
            //問題になる単語(ex 最初はapple)
            let data2 = data1[indexStr]
            
            
            //단어 전체키값이 들어있음 data[0]도 들어있음
            //問題を含め全単語のkey値がkeys_に入る
            var keys_ = [Any]()
            keys_ = Array(data1.keys)
            
            var comparKey:Any=""
            //여기에 담음
            var answerKeyList = [Any]()
            var f = 0
            
            //data2의 키와 비교
            //正解とcompare
            for keys in 0...keys_.count{
                
                if f==keys_.count{
                    break
                }
                
                comparKey = keys_[f]
                print(comparKey,indexStr)
                
                if comparKey as AnyObject !== indexStr as AnyObject{
                    
                    if comparKey as AnyObject !== "uid" as AnyObject{
                    
                        answerKeyList.append(comparKey)
                    f += 1
                    
                    }
                    else{ f += 1}
                }
                else { f += 1}
                print(f)
            }
            //이처리가 끝나면 answerKeyList에 정답과 uid를 뺀 나머지 키값이 들어있고 여기서 랜덤으로 3개만 꺼내쓰면됨
            //ここまでの処理が終わったらanswerKeyListに、正解とuidを除外した全単語のkey値が入ってる。ここでrandomで3個出して選択肢にする。
            
            var finalAnswerList:Set<Int>=[]
            var ramdomkey_:Int=0
            
            var s :Int=1
            
            //정답자리 채워놓고 3개만 배열에 채우는 작업
            //選択肢arrayに正解を入れておく
            var index_int = Int(indexStr)
            finalAnswerList.insert(index_int!)
            
            var check = false
            
            var check_ = false
            
            
            //크게3번돔
            //3回まわる
            while finalAnswerList.count < 4 {
                
                
                ramdomkey_ = Int.random(in: 0...answerKeyList.count)
                
                
                //정답키와 랜덤으로 고른키가 같으면 true로 바꾸고 다른키골라야함
                //正解keyとrandomKeyが同じならflagを立てて違うkeyを取得
                if ramdomkey_ == index_int{
                    
                    check = true
                    
                    while check==true {
                        ramdomkey_ = Int.random(in: 0...answerKeyList.count)
                        if ramdomkey_ != index_int{
                            
                            if finalAnswerList.contains(ramdomkey_){}
                            else{
                            check=false
                                finalAnswerList.insert(ramdomkey_)
                                
                            }
                        }
                    }
                }
                
                else{
                
                    finalAnswerList.insert(ramdomkey_)
                    
                }
                
            }
            //이처리까지 끝나면 finalAnswerList에 중복없이 정답과 선택지 키가 4개들어있다.
            //ここまで処理が終わったらfinalAnswerListに正解を含め、重複無しの選択肢が入ってる
            
            if data2 == nil {
                            self.TestEnglishWord.text = "単語がありません"
                            break;
                        }
                        
                        print(data2)
                        
                        let data3:[String:AnyObject] = data2 as! [String : AnyObject]
                        
                        let engWd : NSString? = data3["eng"]! as? NSString
                        //正解
                        let jpnWd : NSString? = data3["jpn"]! as? NSString
                        
                        self.TestEnglishWord.text = engWd as? String
                        
            var index_b = 1
            var index_count = 0
            
            for testdata in finalAnswerList{
                print(testdata)
                var testdata_ = String(describing: testdata)
                let test = data1[testdata_]
                let test_:[String:AnyObject] = test as! [String : AnyObject]
                let testjp : NSString? = test_["jpn"]! as? NSString
                print(testjp)
                var t = String(describing: index_b)
                //TestAnswer_1.=testjp
                
                switch index_count{
                
                case 0 : self.TestAnswer_1.setTitle(testjp as String?, for: .normal)
                        break
                case 1 : self.TestAnswer_2.setTitle(testjp as String?, for: .normal)
                        break
                case 2 : self.TestAnswer_3.setTitle(testjp as String?, for: .normal)
                        break
                case 3 : self.TestAnswer_4.setTitle(testjp as String?, for: .normal)
                        break
                
                default:
                    break
                }
                
                index_b += 1
                index_count += 1
                
                
            }
                self.TestviewWordListIndex += 1;
                    }
                }
               return TestviewWordListIndex
            }
    
    
    @IBAction func TappedBackButton(_ sender: Any) {
        
        transitionToHome()
        
    }
    
    func transitionToHome(){
        
        let homeViewController =
        storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
       
    }
  
}
