//
//  TimetableViewController.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/7/17.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//
import UIKit

class TimetableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var timetable: UITableView!
    var uid:String = "";
    var button: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let uid = NSUserDefaults.standardUserDefaults().objectForKey("AutoLogin") as! String
        
        let alertController = UIAlertController(title: "Information", message: "your id is "+uid, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:nil)
        alertController.addAction(okAction)
        
        
        
        self.presentViewController(alertController, animated:true, completion:nil)
        
        timetable.delegate=self;
        timetable.dataSource=self;
        
        
        
        addButton("M",Time_Start: "0415",Time_End: "0615")
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 25;
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        if(indexPath.row == 0)
        {
            return 66;
        }
        else
        {
            return 80;
        }
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        if(indexPath.row == 0)
        {
            let cell = self.timetable.dequeueReusableCellWithIdentifier("timetable_cell1")!
                
                as UITableViewCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            
            return cell;
        }
        else
        {
            let cell = self.timetable.dequeueReusableCellWithIdentifier("timetable_cell2")!
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            let cell_1=cell.viewWithTag(101) as! UILabel
            cell_1.text="\(indexPath.row)"
            
            return cell
            
        }
        
        
        
    }
    
    
    
    //
    
    func addButton(Day:String,Time_Start:String,Time_End:String)
    {
        let Time_Start_mins_int:Int?=Int((Time_Start as NSString).substringFromIndex(Time_Start.characters.count-2));
        
        let Time_End_mins_int:Int?=Int((Time_End as NSString).substringFromIndex(Time_End.characters.count-2));
        
        let Time_Start_hours_int:Int?=Int((Time_Start as NSString).substringToIndex(Time_Start.characters.count-2))
        
        let Time_End_hours_int:Int?=Int((Time_End as NSString).substringToIndex(Time_End.characters.count-2))
        
        
        let Time_Start_position=(Double(Time_Start_mins_int!)/60*80+Double(Time_Start_hours_int!)*80)
        
        let Time_End_position=Double(Time_End_mins_int!)/60*80+Double(Time_End_hours_int!)*80
        
        let Time_Start_position_int:Int=Int(Time_Start_position)
        
        let Time_End_position_int:Int=Int(Time_End_position)
        
        //var button: UIButton?
        
        let view_width=timetable.frame.width;
        //print(view_width/8)
        
        var view_hight=timetable.frame.height;
        
        button = UIButton(frame: CGRect(x:Int(view_width/8)+Int(view_width/8/2) , y: Time_Start_position_int, width: Int(view_width/8), height: Time_End_position_int-Time_Start_position_int))
        button?.backgroundColor=UIColor.orangeColor()
        button?.tag=1;
        button!.addTarget(self, action:#selector(clickEvent), forControlEvents: UIControlEvents.TouchUpInside)
        
        timetable.addSubview(button!)
        
        
        if(Day=="M")
        {
            
        }
        
        
        
        
    }
    
    
    func clickEvent(sender: UIButton)
    {
        
        // print(sender.tag)
    }
    
    
    
    
    
}

