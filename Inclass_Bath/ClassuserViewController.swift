//
//  ClassuserViewController.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/9/1.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//

import UIKit
import AFImageHelper
class ClassuserViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{


    @IBOutlet weak var TableView: UITableView!
    var cid: String?
    var uid:String?
    
    var users:[User] = [User]();
    override func viewDidLoad() {
        super.viewDidLoad()
        users=Database.getclassmates(cid!);
        TableView.dataSource = self;
        TableView.delegate=self;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return users.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print(indexPath.row);
        
        let chat = RCConversationViewController()
        //type of conversationType
        chat.conversationType = RCConversationType.ConversationType_PRIVATE
        if(users[indexPath.row]._Usrid != uid)
        {
        chat.targetId = users[indexPath.row]._Usrid
        //Set title
        chat.title = users[indexPath.row]._Username
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chat, animated: true)
        self.hidesBottomBarWhenPushed = false

        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell =
            self.TableView.dequeueReusableCellWithIdentifier("usercell")!
        let cell_photo = cell.viewWithTag(101) as! UIImageView
        let cell_name = cell.viewWithTag(102) as! UILabel
        cell_name.text = users[indexPath.row]._Username
        cell_photo.imageFromURL(users[indexPath.row]._Pic, placeholder:UIImage(named:"loading")! )
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        
        return cell;
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
