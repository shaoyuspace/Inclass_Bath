//
//  Localfiles.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/7/25.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//

import Foundation
struct Localfiles
{
    
    init()
    {
        
    }
    static func savetimetable(m: String , clist: [Class_Time])
    {
        let filename: String = m;
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("\(filename).plist")
        
        
        
        let save: NSMutableData = NSMutableData ()
        
        let  archiver =  NSKeyedArchiver (forWritingWithMutableData: save)
        archiver.encodeObject(clist, forKey:  "classtimeList" )
        archiver.finishEncoding()
        save.writeToFile(path, atomically: true)
        
    }
    static func clear ()
    {
        let fileManager = NSFileManager.defaultManager()
        let myDirectory = NSHomeDirectory() + "/Documents"
        let fileArray:[AnyObject]? = fileManager.subpathsAtPath(myDirectory)
        for fn in fileArray!{
            delete(fn as! String)
            //try! fileManager.removeItemAtPath(myDirectory + "/\(fn)")
        }
    }
    static func delete(s:String)
    {
        let fileManager = NSFileManager.defaultManager()
        let homeDirectory = NSHomeDirectory()
        let srcUrl = homeDirectory + "/Documents/"+s;
        let  defaultManager =  NSFileManager ()
        if  defaultManager.fileExistsAtPath(srcUrl)
        {
        try! fileManager.removeItemAtPath(srcUrl)
        }
    }
    static func checkexit(s:String)->Bool
    {
        let homeDirectory = NSHomeDirectory()
        let srcUrl = homeDirectory + "/Documents/"+s
        let  defaultManager =  NSFileManager ()
        return defaultManager.fileExistsAtPath(srcUrl)
    }
    
    static func  loadData(filename:String)-> [Class_Time] {
        //get local files
        var classtime = [Class_Time]()
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("\(filename).plist")
        let  defaultManager =  NSFileManager ()
        if  defaultManager.fileExistsAtPath(path) {
            //Read Data
            let  data =  NSData (contentsOfFile: path)
            //decoding
            let  unarchiver =  NSKeyedUnarchiver (forReadingWithData: data!)
            //Checklist lists
             classtime = unarchiver.decodeObjectForKey( "classtimeList" )as! [Class_Time]
            //end decoding
            
            unarchiver.finishDecoding()
            return classtime;
        }
        else
        {
            return
            classtime
        }
    }
    
    
}
    