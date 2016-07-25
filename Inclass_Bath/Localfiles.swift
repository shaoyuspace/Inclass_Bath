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
        archiver.encodeObject(clist, forKey:  "userList" )
        archiver.finishEncoding()
        save.writeToFile(path, atomically: true)
        
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
    
    static func  loadData(filename:String) {
        //获取本地数据文件地址
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("\(filename).plist")
        //声明文件管理器
        let  defaultManager =  NSFileManager ()
        //通过文件地址判断数据文件是否存在
        if  defaultManager.fileExistsAtPath(path) {
            //读取文件数据
            let  data =  NSData (contentsOfFile: path)
            //解码器
            let  unarchiver =  NSKeyedUnarchiver (forReadingWithData: data!)
            //通过归档时设置的关键字Checklist还原lists
            let userList = unarchiver.decodeObjectForKey( "userList" )as! [Class_Time]
            //结束解码
            for u in userList
            {
                print(u.name);
                
            }
            
            unarchiver.finishDecoding()
        }
    }
    
    
}
    