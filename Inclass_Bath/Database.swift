//
//  Database.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/7/17.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//

import Foundation

class Database
{
    
    
    
   
    
    
    
    
    static func storeUser (email:String, password:String, gender:String, realname:String, bdate:String, username:String)->String
    {
        var response: NSURLResponse?
        let request = NSMutableURLRequest(URL: NSURL(string: "http://47.88.189.123/Index.php")!)
        request.HTTPMethod = "POST"
        let body = "tag=storeUser&email=\(email)&password=\(password)&gender=\(gender)&realname=\(realname)&bdate=\(bdate)&username=\(username)"
        let postData = body.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = postData
        
        let received:NSData? = try? NSURLConnection.sendSynchronousRequest(request,returningResponse: &response)
        
//        var datastring = NSString(data: received!, encoding: NSUTF8StringEncoding)
        

        let result2 = (try! NSJSONSerialization.JSONObjectWithData(received!, options: NSJSONReadingOptions())) as! NSDictionary
        let result = result2["uid"]as! String
        return result
        
    }

    static func isUserExisted(email:String)->Bool
    {
        
        var response: NSURLResponse?
        let request = NSMutableURLRequest(URL: NSURL(string: "http://47.88.189.123/Index.php")!)
        request.HTTPMethod = "POST"
        let body = "tag=isUserExisted&email=\(email)"
        let postData = body.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = postData
        let received:NSData? = try? NSURLConnection.sendSynchronousRequest(request,returningResponse: &response)
        let result2 = (try! NSJSONSerialization.JSONObjectWithData(received!, options: NSJSONReadingOptions())) as! NSDictionary
        return (result2["error"]as! Bool)
        
        
    }
    
    
    static func getuser (userid:String)->User
    {
        
        var user = User(error: false);
        
        
        
        var response: NSURLResponse?
        let request = NSMutableURLRequest(URL: NSURL(string: "http://47.88.189.123/Index.php")!)
        request.HTTPMethod = "POST"
        let body = "tag=getuser&userid=\(userid)"
        let postData = body.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = postData
        let received:NSData? = try? NSURLConnection.sendSynchronousRequest(request,returningResponse: &response)
        
        
        let result2 = (try! NSJSONSerialization.JSONObjectWithData(received!, options: NSJSONReadingOptions())) as! NSDictionary
        
        user._Error=result2["error"]as! Bool
        if(user._Error == false)
        {
            user._Pic=result2["pic"] as! String
            user._Username=result2["username"] as! String
            user._Bdate=result2["bdate"] as! String
            user._Realname=result2["realname"] as! String
            user._Gender=result2["gender"]as! String
            user._Password=result2["password"]as! String
            user._Email=result2["email"]as! String
            user._Usrid=result2["uid"]as! String
            user._Usertoken=result2["token"]as! String
        }
        
        //print (result2)
        return user;
    }
    static func login (email:String, password:String)->User
    {

        var user = User(error: false);
        
        

        var response: NSURLResponse?
        let request = NSMutableURLRequest(URL: NSURL(string: "http://47.88.189.123/Index.php")!)
        request.HTTPMethod = "POST"
        let body = "tag=Check&email=\(email)&password=\(password)"
        let postData = body.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = postData
        let received:NSData? = try? NSURLConnection.sendSynchronousRequest(request,returningResponse: &response)
        
        
        let result2 = (try! NSJSONSerialization.JSONObjectWithData(received!, options: NSJSONReadingOptions())) as! NSDictionary
        
        user._Error=result2["error"]as! Bool
        if(user._Error == false)
        {
        user._Pic=result2["pic"] as! String
        user._Username=result2["username"] as! String
        user._Bdate=result2["bdate"] as! String
        user._Realname=result2["realname"] as! String
        user._Gender=result2["gender"]as! String
        user._Password=result2["password"]as! String
        user._Email=result2["email"]as! String
        user._Usrid=result2["uid"]as! String
        user._Usertoken=result2["token"]as! String
        }
        
        //print (result2)
        return user;
    }
    }
    