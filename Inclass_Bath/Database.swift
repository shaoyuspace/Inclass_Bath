//
//  Database.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/7/17.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//

import Foundation
import Alamofire
class Database
{
    // upload file
    
    static func notificationBtnClick()
    {
        print("update")

    }

    static func upload(filename: String)
    {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent(filename)
        let fileURL:NSURL = NSURL.init(fileURLWithPath: path)
        
        
        Alamofire.upload(
            .POST,
            "http://47.88.189.123/upload2.php",
            multipartFormData: { multipartFormData in
                
                multipartFormData.appendBodyPart(fileURL: fileURL, name: "file")
            },
            encodingCompletion: { encodingResult in
                print("file is alraldy to upload")
        NSNotificationCenter.defaultCenter().postNotificationName("update",
                    object: self, userInfo:nil)
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseString { response in
                        print(response)
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
            }
        )

    }
    // delete user from the mysql
    
    static func delete(uid: String)
    {
        var response: NSURLResponse?
        let request = NSMutableURLRequest(URL: NSURL(string: "http://47.88.189.123/Index.php")!)
        request.HTTPMethod = "POST"
        var body = "tag=delete&uid=\(uid)"
        //print(body);
        let postData = body.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = postData
        try? NSURLConnection.sendSynchronousRequest(request,returningResponse: &response)

        
        
    }
    
    
    static func addclass(uid: String,classlist:Set<String>,Year:String)

    {
        
        var response: NSURLResponse?
        let request = NSMutableURLRequest(URL: NSURL(string: "http://47.88.189.123/Index.php")!)
        request.HTTPMethod = "POST"
        var body = "tag=addclass&uid=\(uid)&year=\(Year)"
        for c in classlist
        {
            body = body + "&classlist[]=\(c)";
        }
        //print(body);
        let postData = body.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = postData
        try? NSURLConnection.sendSynchronousRequest(request,returningResponse: &response)
    
        
        
    }
    
    
    
    
    
    


    static func storeUser (email:String, password:String, gender:String, realname:String, bdate:String, username:String)->String
    {
        var response: NSURLResponse?
        let request = NSMutableURLRequest(URL: NSURL(string: "http://47.88.189.123/Index.php")!)
        request.HTTPMethod = "POST"
        let body = "tag=storeUser&email=\(email)&password=\(password)&gender=\(gender)&realname=\(realname)&bdate=\(bdate)&username=\(username)"
        let postData = body.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = postData
        
        let received:NSData? = try? NSURLConnection.sendSynchronousRequest(request,returningResponse: &response)
        let result2 = (try! NSJSONSerialization.JSONObjectWithData(received!, options: NSJSONReadingOptions())) as! NSDictionary
        let result = result2["uid"]as! String
        return result
        
    }
    static func getclassmates (cid: String)->[User]
    {
        var users:[User] = [User]();
        var response: NSURLResponse?
        let request = NSMutableURLRequest(URL: NSURL(string: "http://47.88.189.123/Index.php")!)
        request.HTTPMethod = "POST"
        let body = "tag=getclassmates&cid=\(cid)"
        let postData = body.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = postData
        let received:NSData? = try? NSURLConnection.sendSynchronousRequest(request,returningResponse: &response)
        
        
        let result2 = (try! NSJSONSerialization.JSONObjectWithData(received!, options: NSJSONReadingOptions())) as! NSDictionary
        for (k,v) in result2
        {
            if(k as! String != ("tag") && k as! String != ("error"))
            {
                let u = User(uid: v["uid"] as! String, username: v["username"] as! String, pic: v["pic"] as! String);
                users.append(u);

            }
      
        }
        return users;
    }
    static func getclass(name: String)->[String]
    {
        var slist:[String] = [String]();
        
        var response: NSURLResponse?
        let request = NSMutableURLRequest(URL: NSURL(string: "http://47.88.189.123/Index.php")!)
        request.HTTPMethod = "POST"
        let body = "tag=getclass&cuid=\(name)"
        let postData = body.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = postData
        let received:NSData? = try? NSURLConnection.sendSynchronousRequest(request,returningResponse: &response)
        let result2 = (try! NSJSONSerialization.JSONObjectWithData(received!, options: NSJSONReadingOptions())) as! NSDictionary
        var type = result2["type"] as! String
        if(type == "0")
        {
            slist.append(type);
            slist.append(result2["cid"] as! String);
            slist.append(result2["name"] as! String);
            slist.append(result2["website"] as! String);
            
        }
        else
        {
            slist.append(type);
        }
        return  slist;
        
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
        user._Timetable=result2["timetable"]as! String
        }
        return user;
    }
    }
    