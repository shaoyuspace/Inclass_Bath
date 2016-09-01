//
//  User.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/5/25.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//

import Foundation
import UIKit
struct User {
    var _Usrid : String = ""
    var _Email: String = ""
    var _Password: String = ""
    var _Gender: String = ""
    var _Realname:String = ""
    var _Bdate:String = ""
    var _Username:String = ""
    var _Pic:String=""
    var _Usertoken:String=""
    var _Timetable:String=""
    var _Error = false;
    
    
//    init(Email:String,Password:String)
//    {
//        self._Email=Email
//        self._Email=Email
//        
//    }
    init (error:Bool)
    {
        self._Error=error;
    }
    init (uid: String,username: String,pic: String)
    {
        self._Usrid = uid;
        self._Username = username;
        self._Pic = pic;
    }
    init(Email:String,Password:String,Gender:String,Realname:String,Username:String,Bdate:String,Pic:String,Usertoken:String,Timetable:String)
    {
        self._Email=Email
        self._Password=Password
        self._Gender=Gender
        self._Realname=Realname
        self._Bdate=Bdate
        self._Username=Username
        self._Pic=Pic
        self._Usertoken=Usertoken
        self._Timetable=Timetable
                
    }


}