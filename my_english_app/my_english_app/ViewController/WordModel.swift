//
//  WordModel.swift
//  my_english_app
//
//  Created by 金相恩 on 2020/04/28.
//  Copyright © 2020 Kim. All rights reserved.
//

import Foundation

class WordModel {
    var word: String?
    var japanese: String?
    var complete: Bool?
    
    init(word:String?, japanese:String?, complete:Bool?) {
        self.word = word;
        self.japanese = japanese;
        self.complete = complete;
    }
}
