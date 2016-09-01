//
//  ClasspageViewController.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/8/31.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//

import UIKit
import MBProgressHUD
import SafariServices

class ClasspageViewController: UIViewController {
    
    var name: String?
    var location: String?
    var cid: String?
    var time: String?
    var website: String?
    var unitid: String?
    var uid: String?
    var type: Int?
    @IBOutlet weak var ClassUid: UILabel!
    @IBOutlet weak var Classname: UILabel!
    
    @IBOutlet weak var Classtime: UILabel!
    @IBOutlet weak var ClassLocation: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ClassUid.text = unitid;
        Classtime.text = time;

        ClassLocation.text=location;
        asyncShow()
        
        
    }
    @IBAction func GoCommetns(sender: AnyObject) {
    }
    @IBAction func Gowebpage(sender: AnyObject) {
        
        let url = NSURL(string: website!)
 
        let safariCtrl = SFSafariViewController(URL: url!)
        safariCtrl.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(safariCtrl, animated: true)
        
    }
    @IBAction func GoClassmates(sender: AnyObject) {
        

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoClassmates"
        {
            let vc = segue.destinationViewController as! ClassuserViewController
            vc.cid=cid;
            vc.uid=uid;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func asyncShow(){
        var list:[String] = [String]()
       // let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
       // hud.labelText = "loading"
        
        //hud.showAnimated(true, whileExecutingBlock: {

            list = Database.getclass((self.unitid! as NSString).substringToIndex(7));

//            sleep(2)
//        }) {
            //执行完成后的操作，移除
            if(list.count == 1)
            {
                self.type = 1
                self.Classname.text = self.unitid
            }
            else
            {
                self.type = 0
                self.cid = list[1]
                self.name = list[2]
                self.website = list[3]
                self.Classname.text = self.name
                
                
            }
            //hud.removeFromSuperview()
        //}
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
