//
//  Ument.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/8/14.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//

import Foundation
import UIKit
class Ument:NSObject{
    var _Umentid : String = ""
    var _Username: String = ""
    var _Date: String = ""
    var _Commentnum: Int = 0
    var _Pic: String = ""
    var _Content: String = ""
    var _Photo: String = ""
    init(umentid:String,username:String,date:String,commentnum:Int, pic:String,content:String,photo:String)
    {
        self._Umentid = umentid
        self._Username = username
        self._Date = date
        self._Commentnum = commentnum
        self._Pic = pic
        self._Content = content
        self._Photo = photo
    }
}