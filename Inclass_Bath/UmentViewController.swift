//
//  UmentViewController.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/8/14.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//

import UIKit
import AFImageHelper
import ZZRefresh
class UmentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var umenttable: UITableView!
    var uments:[Ument] = [Ument]()
    var rows: NSInteger = 20

    override func viewDidLoad() {
        //uments = [Ument]()

        super.viewDidLoad()


        let ument = Ument(umentid: "12",username: "shao",date: "2010-02-04",commentnum: 0, pic: "0",content: "dasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdla",photo: "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQjl6-mUQe6PN17lBz6AGLG4BwfNVx62zvSsBzU5HKhRS9TfZPz")
        uments.append(ument)
        for a in 1...20
        {
        let ument1 = Ument(umentid: "12",username: "shao",date: "2010-02-04",commentnum: 0, pic: "http://dingyue.nosdn.127.net/ltbbPw=HVt5aaFZDe4kYegGQUOA3T90sYoD6DpoiOC0y1465227162302.jpg",content: "dasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdla\ndasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsah\njdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasf\njsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdla",photo: "0")
        uments.append(ument1)
        }
        umenttable.delegate = self
        umenttable.dataSource = self
        
        pullLoadData()
        loadMore()

    }
    
    
    func pullLoadData() {
        if let umenttable = umenttable {
            umenttable.zz_pullToRefresh { [unowned self] () -> Void in ()
                //print("正在刷新。。。。。")
                let delayInSeconds: Double = 1.0
                let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
                dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in ()
                    //print("结束刷新。。。。。")
                    let ument = Ument(umentid: "12",username: "你好",date: "2010-02-04",commentnum: 0, pic: "0",content: "dasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdladasdnksalfklasfjsahjdlsdnksalfklasfjsahjdla",photo: "https://encrypted-tbngstatic.com/images?q=tbn:ANd9GcQjl6-mUQe6PN17lBz6AGLG4BwfNVx62zvSsBzU5HKhRS9TfZPz")
                    self.uments.insert(ument, atIndex: 0)
                    umenttable.endRefreshing()
                    self.rows = 20
                    umenttable.reloadData()
                })
            }
        }
    }
    
    func loadMore() {
        if let umenttable = umenttable {
            umenttable.zz_loadMoreWhen(0.9, offsetMINButtom: 20) { [unowned self] () -> Void in ()
                //print("加载更多")
                let delayInSeconds: Double = 1.0
                let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
                dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in ()
                    //print("加载完成。。。。。")
                    self.rows = self.rows + 10
                    if (self.rows >= self.uments.count) {
                        umenttable.zz_noMoreData()
                        print("已经全部加载。。。。。")
                    }
                    umenttable.reloadData()
                    umenttable.zz_endloadMore()
                })
            }
            
        }
        
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       return (uments.count)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
         var hight = heightForView(uments[indexPath.row]._Content, font: UIFont(name: "Helvetica", size: 15.0)!, width: self.umenttable.frame.width)
        
        
        let cell =
            self.umenttable.dequeueReusableCellWithIdentifier("umentcell")!
        if(uments[indexPath.row]._Pic == "0")
        {
            hight = hight - 150;
        }
        
        return cell.contentView.frame.height+hight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        
        
        
        let cell =
        self.umenttable.dequeueReusableCellWithIdentifier("umentcell")!
        let cell_photo = cell.viewWithTag(1) as! UIImageView
        let cell_name = cell.viewWithTag(2) as! UILabel
        let cell_content = cell.viewWithTag(4) as! UILabel
        let cell_pic = cell.viewWithTag(5) as! UIImageView
        let cell_likebutton = cell.viewWithTag(6) as! UIButton
        let cell_commentbutton = cell.viewWithTag(7) as! UIButton
        let  ument = (uments[indexPath.row])
        cell_name.text = ument._Username
        cell_content.text = ument._Content
        
        
        
        if(ument._Pic == "0")
        {
            cell_pic.image = nil
            cell_pic.frame.size.height =  CGFloat(0)
        }
        else
        {
        cell_pic.imageFromURL(ument._Pic, placeholder: UIImage(named:"loading")!)
        }
        cell_photo.imageFromURL(ument._Photo, placeholder:UIImage(named:"loading")! )
        cell_likebutton.layer.borderColor = UIColor.blueColor().CGColor
        cell_likebutton.layer.borderWidth = 0.5
        
        cell_commentbutton.layer.borderColor = UIColor.blueColor().CGColor
        cell_commentbutton.layer.borderWidth = 0.5
        
        
        
        return cell;
        
        
        
        
    }
    
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
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
