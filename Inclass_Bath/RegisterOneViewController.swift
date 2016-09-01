//
//  ViewController.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/5/24.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//

import UIKit

class RegisterOneViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var User_Password: UITextField!
    @IBOutlet weak var User_Email: UITextField!
    @IBOutlet weak var User_RePassword: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        User_Password.delegate=self
        User_Email.delegate=self
        User_RePassword.delegate=self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        User_Password.resignFirstResponder()
        User_Email.resignFirstResponder()
        User_RePassword.resignFirstResponder()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Sign_Next"
        {
            let vc = segue.destinationViewController as! RegisterTwoViewController
            vc.Email = User_Email.text
            vc.Password=User_Password.text
        }
    }

    @IBAction func NextTapped(sender: AnyObject) {
        
        
        
        if(check(User_Email.text!,Password: User_Password.text!,Repassword: User_RePassword.text!) == true)
        {
            let checkuser = Database.isUserExisted(User_Email.text!)
            if(checkuser == true)
            {
                let alter = UIAlertView()
                alter.addButtonWithTitle("Ok")
                alter.message = "The E-mail has been Registered."
                alter.show()
            }
            else{
            self.performSegueWithIdentifier("Sign_Next", sender: self)
            }
        }
        else{
       
            let alter = UIAlertView()
            alter.addButtonWithTitle("Ok")
            alter.message = "Your password field and comfimation field cannot be empty."
            alter.show()
        }
        
        
      
    }

    func check (Email:String,Password:String,Repassword:String)->Bool
    {
        
        
        if ((Email != "") && (Password != "") && (Repassword != "") && (Password == Repassword))
        {
            return true
        }
        else
        {
            return false
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        
        
        if textField == User_Email
        {
            User_Password.becomeFirstResponder()
            
        }
        else if textField == User_Password
        {
            User_RePassword.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }

    
    
}

