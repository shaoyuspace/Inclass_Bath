//
//  ViewController.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/5/24.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//

import UIKit

class RegisterTwoViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var UserRealName: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var Bdata: UIDatePicker!
    @IBOutlet weak var Gender: UISegmentedControl!
    var Email:String?
    var Password:String?
    var _user: User?
    private let defaults = NSUserDefaults.standardUserDefaults()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserRealName.delegate=self;
        username.delegate=self;
        
        // Do any additional setup after loading the view, typically from a nib.
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        UserRealName.resignFirstResponder()
        username.resignFirstResponder()
    }

    
    @IBAction func RegisterTapped(sender: AnyObject) {
        let genderText = Gender.selectedSegmentIndex==0 ? "M" : "W"
        let bdateText = DateToString(Bdata.date)
        let realname = UserRealName.text!
        let username_ = username.text!
        let email_ = Email!
        let pas = Password!
        //print(bdateText)
        _user=User(Email: email_,Password: pas,Gender: genderText,Realname: realname, Username: username_,Bdate: bdateText,Pic: "0",Usertoken: "0",Timetable: "0")
        
        
        if( check(realname) == false || check (username_) == false )
        {
            let alter = UIAlertView()
            alter.addButtonWithTitle("Ok")
            alter.message = "Your password field and comfimation field cannot be empty."
            alter.show()
        }
        else
        {
            let uid = Database.storeUser((_user?._Email)!, password: (_user?._Password)!, gender: (_user?._Gender)!, realname: (_user?._Realname)!, bdate: (_user?._Bdate)!, username: (_user?._Realname)!)
          let user = Database.login((_user?._Email)!, password: (_user?._Password)!)
            defaults.setObject(uid, forKey: "AutoLogin")
            let appDelgate=UIApplication.sharedApplication().delegate as? AppDelegate
            appDelgate?.setuser(user);
            appDelgate?.connectIMServer({()->Void in print("连接成功")},user_info: user)
            self.performSegueWithIdentifier("login12", sender: self)
            
            
        }
        
    
    }
    func check (str: String)->Bool
    {
        if(str == "")
        {
            return false
        }

        else
        {
            return true
        }
    }
    func DateToString(date: NSDate) -> String
    {
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let temp = formatter.stringFromDate(date)
        let dateString = temp.substringWithRange(Range<String.Index>(start: temp.startIndex, end: temp.startIndex.advancedBy(10)))
        
        return dateString
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        
        
        if textField == UserRealName
        {
            username.becomeFirstResponder()
            
        }
  
        textField.resignFirstResponder()
        return true
    }

    
    
}

