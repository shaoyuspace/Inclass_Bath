//
//  TimetableViewController.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/7/17.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//
import UIKit
import Alamofire

class TimetableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var timetable: UITableView!
    @IBOutlet weak var show_current: UIButton!
    var uid:String = "";
    //var button: UIButton?
    var current: NSDate?
    var startweek: NSDate?
    var endweek: NSDate?
    var classtimes: [Class_Time]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let uid = NSUserDefaults.standardUserDefaults().objectForKey("AutoLogin") as! String
        
        let alertController = UIAlertController(title: "Information", message: "your id is "+uid, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:nil)
        alertController.addAction(okAction)
        
        
        
        self.presentViewController(alertController, animated:true, completion:nil)
        
        timetable.delegate=self;
        timetable.dataSource=self;
        current = NSDate()
        current = Addday(current!, days: 58)
        
        
        setweekday()
        download()
        //setweekcanlendar()
//        
//        addButton(2,Time_Start: "0430",Time_End: "0615")
//        addButton(0,Time_Start: "0415",Time_End: "0615")
//        addButton(1,Time_Start: "0430",Time_End: "0615")
//        addButton(3,Time_Start: "0415",Time_End: "0615")
//        addButton(4,Time_Start: "0430",Time_End: "0615")
//        addButton(5,Time_Start: "0415",Time_End: "0615")
//        addButton(6,Time_Start: "0415",Time_End: "0615")
        
        
    }
    
    
    func setweekday()
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.locale=NSLocale(localeIdentifier:"en_US")
        
        let calendar = NSCalendar.currentCalendar()
        let currentDateComponents = calendar.components([.YearForWeekOfYear, .WeekOfYear ], fromDate: current!)
        let startOfWeek = calendar.dateFromComponents(currentDateComponents)
        startweek = Addday(startOfWeek!,days: 1)
        endweek = Addday(startOfWeek!,days: 7)
        let convertedstartweek = dateFormatter.stringFromDate(startweek!)
        let convertedendweek = dateFormatter.stringFromDate(endweek!)
        let show=convertedstartweek+"-"+convertedendweek
        show_current.setTitle(show, forState: .Normal)
    }
    
    func setweekcanlendar()
    {
        
        
//        let appDelgate=UIApplication.sharedApplication().delegate as? AppDelegate
//        
//        //let allclasstime = appDelgate?.getallclasstime();
        
        for classtime in self.classtimes!
        {
            //print(classtime.stime)
            let classdate = classtime.stime;
            
            if(classdate.compare(endweek!) == NSComparisonResult.OrderedAscending && classdate.compare(startweek!) == NSComparisonResult.OrderedDescending)
            {
                print(classtime.stime)
                let weekday=getDayOfWeek(classdate);
                print(getDayOfWeek(classdate));
                print(classtime.getstime_string())
                print(classtime.getetime_string())
                addButton(weekday, Time_Start:classtime.getstime_string(), Time_End: classtime.getetime_string(),Titile: classtime.name+"\n"+classtime.getstime_string()+"-"+classtime.getetime_string() )
                
            }
        }
        
        

        
        
        
        
    }
    
    
    func getDayOfWeek(today:NSDate)->Int {

            let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            let myComponents = myCalendar.components(.Weekday, fromDate: today)
            let weekDay = myComponents.weekday as Int
            return Int(weekDay - 2)
        
    }
    
    
    func Addday(data:NSDate,days:Int)->NSDate
    {
        let daysToAdd = days
        return  NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: daysToAdd, toDate: data, options: NSCalendarOptions.init(rawValue: 0))!

    }
    
    func download()
    {
        Localfiles.delete("ys824.plist");
        Localfiles.delete("ys825.plist");
        
        let destination = Alamofire.Request.suggestedDownloadDestination(
            directory: .DocumentDirectory, domain: .UserDomainMask)
        

            Alamofire.download(.GET, "http://47.88.189.123/uploadFiles/ys825.plist", destination: destination)
                .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
                    let percent = totalBytesRead*100/totalBytesExpectedToRead
                    print("已下载：\(totalBytesRead)  当前进度：\(percent)%")
                }
                .response { (request, response, _, error) in
                    self.classtimes = Localfiles.loadData("ys825");
                    self.setweekcanlendar();
            }
        
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
            return 60;
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
    
    func addButton(Day:Int,Time_Start:String,Time_End:String,Titile:String)
    {
        let Time_Start_mins_int:Int?=Int((Time_Start as NSString).substringFromIndex(Time_Start.characters.count-2));
        
        let Time_End_mins_int:Int?=Int((Time_End as NSString).substringFromIndex(Time_End.characters.count-2));
        
        let Time_Start_hours_int:Int?=Int((Time_Start as NSString).substringToIndex(Time_Start.characters.count-3))
        
        let Time_End_hours_int:Int?=Int((Time_End as NSString).substringToIndex(Time_End.characters.count-3))
        
        
        let Time_Start_position=(Double(Time_Start_mins_int!)/60*80+Double(Time_Start_hours_int!-7)*80)
        
        let Time_End_position=Double(Time_End_mins_int!)/60*80+Double(Time_End_hours_int!-7)*80
        
        let Time_Start_position_int:Int=Int(Time_Start_position)
        
        let Time_End_position_int:Int=Int(Time_End_position)
        
        //var button: UIButton?
        
        let myRect:CGRect = UIScreen.mainScreen().bounds;
       // print(myRect.width);
       
        
        let view_width=myRect.width
        
        let xadds=view_width/8;
        print(view_width)
        print(view_width/8)
        
        
        print(Day*Int(view_width/8)+Int((view_width/8)/2))
        print(Int(view_width/8))
        
        
        //let view_hight=timetable.frame.height;

        var button = UIButton(frame: CGRect(x:Day*Int(view_width/8)+Int(xadds) , y: Time_Start_position_int-20, width: Int(view_width/8), height: Time_End_position_int-Time_Start_position_int))


        
        button.setTitle(Titile, forState: .Normal)
        button.titleLabel?.lineBreakMode = NSLineBreakMode(rawValue: 0)!
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(10)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = UIColor(red: 51/255, green: 153/255, blue: 255/255, alpha:1)
        
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.layer.borderWidth = 1
        button.tag=1;
        //button
        button.addTarget(self, action:#selector(clickEvent), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        timetable.addSubview(button)
        

        
        
        
        
    }
    
    
    func clickEvent(sender: UIButton)
    {
        print(sender.currentTitle)
    }
    
    
    
    
    
}

