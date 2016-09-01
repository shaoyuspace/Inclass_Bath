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
    var location:String
    var Index: Int = -1
    
    //构造方法
    init(name:String,stime:NSDate,etime:NSDate,location:String){
        self.name = name
        self.stime = stime
        self.etime = etime;
        self.location = location;
        super.init()
    }
    func addIndex(inedex:Int)
    {
        Index=inedex
    }
    func getIndex()->Int
    {
        return Index;
        
    }
    func getlocation()->String
    {
        return self.location;
    }
    func getstime_string()->String
    {
    
    let calendar = NSCalendar.currentCalendar()
    let dateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: stime)
    let result = "\(dateComponents.hour)" + ":"+"\(dateComponents.minute)";
    return result;
    }
    
    func getetime_string()->String
    {
        
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: etime)
        let result = "\(dateComponents.hour)" + ":"+"\(dateComponents.minute)";
        return result;
        
        
    }
    
    //从nsobject解析回来
    init(coder aDecoder:NSCoder!){
        self.name=aDecoder.decodeObjectForKey("name") as! String
        self.stime=aDecoder.decodeObjectForKey("stime") as! NSDate
        self.etime=aDecoder.decodeObjectForKey("etime") as! NSDate
        self.location=aDecoder.decodeObjectForKey("location") as! String
    }
    
    //编码成object
    func encodeWithCoder(aCoder:NSCoder!){
        aCoder.encodeObject(name,forKey:"name")
        aCoder.encodeObject(stime,forKey:"stime")
        aCoder.encodeObject(etime,forKey:"etime")
        aCoder.encodeObject(location,forKey:"location")
        
        
    }
}