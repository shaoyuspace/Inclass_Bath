//
//  Login-ViewController.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/5/24.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//

import UIKit

class TimetableController: UIViewController{
    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alter = UIAlertView()
        alter.addButtonWithTitle("Ok")
        alter.message = "Welcome "+"\(user!._Username)"
        alter.show()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

