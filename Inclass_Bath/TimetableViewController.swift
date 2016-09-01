//
//  TimetableViewController.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/7/17.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//
import UIKit
import Alamofire
import DatePickerDialog



class OverlapUIButton: UIButton {
    var Overlapping: OverlappingClass?
}
    //Compare time
    func <=(lhs: NSDate, rhs: NSDate) -> Bool {
    let res = lhs.compare(rhs)
    return res == .OrderedAscending || res == .OrderedSame
    }
    func >=(lhs: NSDate, rhs: NSDate) -> Bool {
    let res = lhs.compare(rhs)
    return res == .OrderedDescending || res == .OrderedSame
    }
    func >(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedDescending
    }
    func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
    }
    func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedSame
    }


class TimetableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    

    @IBOutlet weak var timetable: UITableView!
    @IBOutlet weak var show_current: UIButton!
    var uid:String = ""
    var classbuttons: [UIButton]?
    var current: NSDate?
    var startweek: NSDate?
    var endweek: NSDate?
    var classtimes: [Class_Time]?
    var timer:NSTimer!
    var timeline_ :UIView?
    var lasthour:Int?
    var classoverlapping:Dictionary<Int, [OverlappingClass]> = Dictionary()
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        update()
    }
    
    
    func update()
    {
        for button in classbuttons!
        {
            button.removeFromSuperview()
        }
        classbuttons = [];
        self.classbuttons = [];
        self.classtimes = Localfiles.loadData(uid);
        self.setweekcanlendar();
    }
    

  
    @IBAction func choosedate(sender: AnyObject) {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .Date)
        {
            (date) -> Void in
            for button in self.classbuttons!
            {
                button.removeFromSuperview()
            }
            self.classbuttons = [];
            self.current = date
            self.setweekday()
            self.setweekcanlendar()
            
        }
    
    }
    @IBAction func lastweek(sender: AnyObject) {
        
        for button in classbuttons!
        {
            button.removeFromSuperview()
        }
        classbuttons = [];
        self.current = Addday(current!,days:-7)
        setweekday()
        setweekcanlendar()
    }

    @IBAction func nextweek(sender: AnyObject) {
        for button in classbuttons!
        {
            button.removeFromSuperview()
        }
        classbuttons = [];
        self.current = Addday(current!,days:7)
        setweekday()
        setweekcanlendar()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uid = NSUserDefaults.standardUserDefaults().objectForKey("AutoLogin")as! String
        let appDelgate=UIApplication.sharedApplication().delegate as? AppDelegate
        let user = appDelgate?.user
        

        lasthour = -1
        let alertController = UIAlertController(title: "Information", message: "your id is "+uid, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:nil)
        alertController.addAction(okAction)
        
        classbuttons=[UIButton]()
        
        self.presentViewController(alertController, animated:true, completion:nil)
        
        timetable.delegate=self;
        timetable.dataSource=self;
        current = NSDate()
        current = Addday(current!, days: 58)
        setweekday()
        
        
        
        if(user?._Timetable == "1")
        {
        if(Localfiles.checkexit(uid+".plist"))
        {
            self.classtimes = Localfiles.loadData(uid);
            self.setweekcanlendar();
           
        }
        else
        {
            download();
        }
        }
        
        
        
        let myRect:CGRect = UIScreen.mainScreen().bounds;
        // print(myRect.width);
        
        
        let view_width=myRect.width
        
        timeline_ = UIView(frame: CGRect(x:0 , y: 30, width:view_width,  height: 1))
        timeline_!.backgroundColor=UIColor.redColor();
        
        timetable.addSubview(timeline_!);
        
        let now : NSDate = NSDate()
        
       // now = NSDate().dateByAddingTimeInterval(-3600*8)
        updtaetime(now);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"update:", name: "update", object: nil)
        
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(60,
                                                       target:self,selector:#selector(TimetableViewController.tickDown),
                                                       userInfo:nil,repeats:true)
        
        
    }
    
    
    func update(notification: NSNotification)
    {
//        let userInfo = notification.userInfo as! [String: AnyObject]
//        let value1 = userInfo["value1"] as! String
//        let value2 = userInfo["value2"] as! Int
//        let name = "123"
//        print("\(name) 获取到通知，用户数据是［\(value1),\(value2)］")
//        
//        sleep(3)
//        
//        print("\(name) 执行完毕")
        update();
    }
    
    deinit {
        //记得移除通知监听
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func receiveNoti(notification : NSNotification)
    {
        let userInfo = notification.userInfo
        print(userInfo!["action"])
    }
    func updtaetime(now: NSDate)
    {
        //print("bb");

        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Minute, .Hour], fromDate: now)
        var hour = components.hour
        var minute = components.minute
        
        
        if(hour >= 20 )
        {
            hour = 20
            minute = 0
        }
        else if(hour <= 7)
        {
            hour = 7
            minute = 0
        }

        
        
        
        
        let xPosition = timeline_!.frame.origin.x
        
        
        let yPosition = (Double(minute)/60*80+Double((hour-7)*80))
        
        
        let yPosition_int = CGFloat (yPosition)
        
        
        let height = timeline_!.frame.height
        
        let width = timeline_!.frame.size.width
        
        UIView.animateWithDuration(1.0, animations: {
            
            self.timeline_!.frame = CGRectMake(xPosition, yPosition_int , width, height)
            
        })
        
        if(lasthour == -1)
        {
            lasthour = hour
            if(hour == 20)
            {
                hour = 19;
            }
            let numberOfSections = timetable.numberOfSections
            let numberOfRows = timetable.numberOfRowsInSection(numberOfSections-1)
            
            if numberOfRows > 0
            {
                //print(numberOfSections)
                let indexPath = NSIndexPath(forRow: hour-7, inSection: (numberOfSections-1))
                timetable.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
            }
           
            
        }
        

        if(lasthour != hour)
        {
            //print("aa");
            lasthour = hour
            if(hour == 20)
            {
                hour = 19;
            }
                let numberOfSections = timetable.numberOfSections
                let numberOfRows = timetable.numberOfRowsInSection(numberOfSections-1)
        
                if numberOfRows > 0
                {
                    //print(numberOfSections)
                    let indexPath = NSIndexPath(forRow: hour-7, inSection: (numberOfSections-1))
                    timetable.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
                }
           
        
        }
    }

    func tickDown()
    {
        updtaetime(NSDate())
        
    }
    
    //timer.invalidate()
    


    
    
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
        
        classoverlapping = Dictionary()
        

        
        var i = 0;
        for classtime in self.classtimes!
        {
            //print(classtime.stime)
            let classdate = classtime.stime;
            
            if(classdate.compare(endweek!) == NSComparisonResult.OrderedAscending && classdate.compare(startweek!) == NSComparisonResult.OrderedDescending)
            {
                classtime.addIndex(i);
                var ocs = [OverlappingClass]()
                let weekday=getDayOfWeek(classdate);
                if let val = classoverlapping[weekday]
                {
                    var i = 0;
                    ocs = classoverlapping[weekday]!
                    for oc in ocs
                    {
                        if(oc.startime! <= classtime.stime && oc.endtime!>=classtime.stime)
                        {
                            oc.addclass(classtime)
                            classoverlapping[weekday]![i] = oc
                            break;
                        }
                        else if (oc.startime!<=classtime.etime && oc.endtime! >= classtime.etime)
                        {
                            oc.addclass(classtime)
                            classoverlapping[weekday]![i] = oc
                            break;
                        }
                        else if(oc.startime!>=oc.endtime! && oc.endtime!<=classtime.etime)
                        {
                            oc.addclass(classtime)
                            classoverlapping[weekday]![i] = oc
                            break;
                        }
                        i += 1;
                    }
                    
                    if(i == ocs.count)
                    {
                        let oc = OverlappingClass(classtime: classtime)
                        classoverlapping[weekday]?.append(oc)
                    }
                
                }
                else
                {
                    
                    let oc = OverlappingClass(classtime: classtime)
                    ocs = [OverlappingClass]()
                    ocs.append(oc)
                    classoverlapping.updateValue(ocs, forKey:weekday)
                    

                }

            }
            i += 1;
        }
        
        for (key, value) in classoverlapping{
            //print(key)
            for v in value
            {
                
                addButton(key, Time_Start:v.getstime_string(), Time_End: v.getetime_string(),Titile: v.getname()+"\n"+v.getstime_string()+"-"+v.getetime_string()+"\n"+v.getlocation(),Oc:v)
                //print(v.Stringname());
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
        
        let destination = Alamofire.Request.suggestedDownloadDestination(
            directory: .DocumentDirectory, domain: .UserDomainMask)
            Alamofire.download(.GET, "http://47.88.189.123/uploadFiles/"+uid+".plist", destination: destination)
                .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
                    print(totalBytesRead)
                    
                    // This closure is NOT called on the main queue for performance
                    // reasons. To update your ui, dispatch to the main queue.
                    dispatch_async(dispatch_get_main_queue())
                    {
                        print("Total bytes read on main queue: \(totalBytesRead)")
                    }
                }
                .response { (request, response, _, error) in
                    self.classtimes = Localfiles.loadData(self.uid);
                    self.setweekcanlendar();
                   
            }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 13;
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        

            return 80;
    
    }
    

    
    
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        

            let cell = self.timetable.dequeueReusableCellWithIdentifier("timetable_cell2")!
            cell.selectionStyle = UITableViewCellSelectionStyle.None

            let cell_1=cell.viewWithTag(101) as! UILabel
            cell_1.text="\(indexPath.row+1)"
        
        
            return cell

        
        
        
    }
    
    
    
    //
    
    func addButton(Day:Int,Time_Start:String,Time_End:String,Titile:String,Oc:OverlappingClass)
    {
        
        
        let Time_Start_mins_int:Int?=Int((Time_Start as NSString).substringFromIndex(Time_Start.characters.count-2));
        
        let Time_End_mins_int:Int?=Int((Time_End as NSString).substringFromIndex(Time_End.characters.count-2));
        
        let Time_Start_hours_int:Int?=Int((Time_Start as NSString).substringToIndex(Time_Start.characters.count-3))
        
        let Time_End_hours_int:Int?=Int((Time_End as NSString).substringToIndex(Time_End.characters.count-3))
        
        
        let Time_Start_position=(Double(Time_Start_mins_int!)/60*80+Double(Time_Start_hours_int!-7)*80)
        
        let Time_End_position=Double(Time_End_mins_int!)/60*80+Double(Time_End_hours_int!-7)*80
        
        let Time_Start_position_int:Int=Int(Time_Start_position)
        
        let Time_End_position_int:Int=Int(Time_End_position)
        
        
        let myRect:CGRect = UIScreen.mainScreen().bounds;
        
       
        
        let view_width=myRect.width
        
        let xadds=view_width/8;

 
        let button = OverlapUIButton(frame: CGRect(x:Day*Int(view_width/8)+Int(xadds) , y: Time_Start_position_int, width: Int(view_width/8), height: Time_End_position_int-Time_Start_position_int))
        
        button.Overlapping = Oc
        


        
        button.setTitle(Titile, forState: .Normal)
        button.titleLabel?.lineBreakMode = NSLineBreakMode(rawValue: 0)!
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(10)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = UIColor(red: 51/255, green: 153/255, blue: 255/255, alpha:1)
        
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.layer.borderWidth = 1
        
        button.addTarget(self, action:#selector(clickEvent), forControlEvents: UIControlEvents.TouchUpInside)
        
        classbuttons?.append(button)
        timetable.addSubview(button)
    

    
        
        
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
    if let des = segue.destinationViewController as? ClasspageViewController
    {
        let classtime = sender as! Class_Time
        des.unitid=classtime.name
        des.location=classtime.location
        des.time=(classtime.getstime_string())+"-"+(classtime.getetime_string())
        des.uid = uid;
        
        }
        
    }
    
    func clickEvent(sender: OverlapUIButton)
    {
        
    //performSegueWithIdentifier("CoursePage", sender: sender)
        
        
        
        //classtimes[sender.tag].name
        if(sender.Overlapping?.count()==1)
        {
        performSegueWithIdentifier("GoClass", sender: sender.Overlapping!.classtimelist[0])
        //print((sender.Overlapping?.classtimelist[0].name)!+"\n")


            
        }
        else
        {

            
            let pickerView = CustomPickerDialog.init()
            

            
            pickerView.setDataSource((sender.Overlapping?.classtimelist)!)
            //pickerView.selectValue(lblResult.text!)
            
            pickerView.showDialog("Class Choose", doneButtonTitle: "done", cancelButtonTitle: "cancel") { (result) -> Void in
                self.performSegueWithIdentifier("GoClass", sender: result)
                
            }

            
            
                        
        }
        
    }
    


    
    
    
    
    
}



