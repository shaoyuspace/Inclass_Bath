//
//  OverlappingClass.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/8/25.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//

import Foundation
class OverlappingClass: NSObject{
    var classtimelist: [Class_Time] = [Class_Time]()
    var startime: NSDate?
    var endtime:NSDate?
    init(classtime: Class_Time)
    {
        startime = classtime.stime;
        endtime = classtime.etime;
        classtimelist.append(classtime)
    }
    func count()->Int
    {
        return classtimelist.count
    }
    func getname()->String
    {
        if(count()==1)
        {
            return classtimelist[0].name;
        }
        else
        {
            return "More";
        }
    }
    func getlocation()->String
    {
        if(count()==1)
        {
            return classtimelist[0].getlocation();
        }
        else
        {
            return "";
        }
    }
    func Stringname()->String
    {
        
        var retult=getstime_string()+"---"+getetime_string()+"\n";
        for c in classtimelist
        {
            retult=retult+c.name+":"+c.getstime_string()+"-"+c.getetime_string()+"\n"
        }
        retult  = retult+"\n"+"-----------------------------";
        return retult;
    }
    func addclass(classtime: Class_Time)
    {
        classtimelist.append(classtime)
        startime=classtime.stime.earlierDate(startime!)
        endtime=classtime.etime.laterDate(endtime!)
    }
    
    func getstime_string()->String
    {
        
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: startime!)
        let result = "\(dateComponents.hour)" + ":"+"\(dateComponents.minute)";
        return result;
    }
    
    func getetime_string()->String
    {
        
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: endtime!)
        let result = "\(dateComponents.hour)" + ":"+"\(dateComponents.minute)";
        return result;
        
        
    }
}