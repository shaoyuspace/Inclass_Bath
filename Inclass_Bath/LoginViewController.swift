//
//  ViewController.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/5/24.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var User_Password: UITextField!
    @IBOutlet weak var User_Email: UITextField!
    private let defaults = NSUserDefaults.standardUserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Localfiles.clear();
        User_Password.delegate=self
        User_Email.delegate=self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        User_Password.resignFirstResponder()
        // User_Email.resignFirstResponder()
    }
    
    @IBAction func LoginTapped(sender: AnyObject) {
        if(check (User_Email.text!,str1: User_Password.text!) == false)
        {
            let user="Username: "+User_Email.text!
            let password="Password: "+User_Password.text!
            let alertController = UIAlertController(title: "Information", message: user+"\n"+password, preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:nil)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated:true, completion:nil)
        }
            
        else
        {
            
            let user = Database.login(User_Email.text!, password: User_Password.text!)
            if(user._Error == false)
            {
                defaults.setObject(user._Usrid , forKey: "AutoLogin")
                let appDelgate=UIApplication.sharedApplication().delegate as? AppDelegate
                appDelgate?.setuser(user);
                appDelgate?.connectIMServer({()->Void in print("连接成功")},user_info: user)
                self.performSegueWithIdentifier("login11", sender: self)
                
            }
                
            else
            {
                let alertController = UIAlertController(title: "Information", message: "Passsword is not correct!", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:nil)
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated:true, completion:nil)
                
            }
        }
        
    }
    func check (str: String, str1: String  )-> Bool
    {
        if(str == "" || str == "")
        {
            return false
        }
        else
        {
            return true
        }
    }
    //UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if textField == User_Email
        {
            User_Password.becomeFirstResponder()
            
        }
        else
        {
            textField.resignFirstResponder()
        }
        return true
    }
    
    


    
    
    
}

