//
//  Class_Time.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/7/25.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//
import UIKit

class Class_Time: NSObject {
    var name:String
    var stime:NSDate
    var etime:NSDate
    
    //构造方法
    init(name:String,stime:NSDate,etime:NSDate){
        self.name = name
        self.stime = stime
        self.etime = etime;
        
        super.init()
    }
    
    //从nsobject解析回来
    init(coder aDecoder:NSCoder!){
        self.name=aDecoder.decodeObjectForKey("name") as! String
        self.stime=aDecoder.decodeObjectForKey("stime") as! NSDate
        self.etime=aDecoder.decodeObjectForKey("etime") as! NSDate
    }
    
    //编码成object
    func encodeWithCoder(aCoder:NSCoder!){
        aCoder.encodeObject(name,forKey:"name")
        aCoder.encodeObject(stime,forKey:"stime")
        aCoder.encodeObject(etime,forKey:"etime")
        
        
    }
}