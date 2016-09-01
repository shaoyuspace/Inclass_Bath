//
//  AddtimetableViewController.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/7/25.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//

import UIKit
import EventKit
import Alamofire

class AddtimetableViewController: UIViewController {
    let uid = NSUserDefaults.standardUserDefaults().objectForKey("AutoLogin") as! String
    var classlist = Set<String>()
    @IBAction func Click(sender: AnyObject) {
        let appDelgate=UIApplication.sharedApplication().delegate as? AppDelegate
        
        if(appDelgate?.user?._Timetable == "1")
        {
            Localfiles.delete(uid);
            Database.delete(uid);
        }
        else
        {
            appDelgate?.user?._Timetable = "1"
            
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            //处理耗时操作的代码块...
            self.savetime();
            
            //操作完成，调用主线程来刷新界面
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
        self.navigationController?.popToRootViewControllerAnimated(true)
            })
        })
        
        

        
        

    }
    
    func savetime()
    {
        let eventStore:EKEventStore = EKEventStore()
        eventStore.requestAccessToEntityType(.Event, completion: {
            granted, error in
            if (granted) && (error == nil) {
                
                let cans = eventStore.calendarsForEntityType(EKEntityType.Event)
                
                var cans1 = [EKCalendar]();
                for can in cans
                {
                    //print(can.title)
                    if(can.title == "University of Bath personal timetable - ys823")
                    {
                        
                        cans1.append(can)
                    }
                    
                }
                
                
                if(cans1.count != 0)
                {
                    let currentDate = NSDate()
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy"
                    let year = dateFormatter.stringFromDate(currentDate)
                    let dateAsString = "03-10-2016"
                    dateFormatter.dateFormat = "dd-MM-yyyy"
                    let startDate=dateFormatter.dateFromString(dateAsString);
                    
                    let endDate=NSDate().dateByAddingTimeInterval(3600*24*360)
                    let predicate2 = eventStore.predicateForEventsWithStartDate(startDate!,
                        endDate: endDate, calendars: cans1)
                    
                    let eV = eventStore.eventsMatchingPredicate(predicate2) as [EKEvent]!
                    
                    
                    var class_List = [Class_Time]()
                    if eV != nil {
                        for i in eV {
                            
                            let ct = Class_Time(name: i.title,stime: i.startDate,etime: i.endDate,location:i.location!as String);
                            let classname = (i.title as NSString).substringToIndex(7) as String
                            class_List.append(ct);
                            self.classlist.insert(classname);
                            
                        }
                        
                        Localfiles.savetimetable(self.uid, clist: class_List)
                        Database.addclass(self.uid, classlist: self.classlist, Year: "2016-2017")
                        Database.upload(self.uid+".plist")
                        
                    }
                    
                }
                else
                {
                    
                    print("can not find");
                    
                }
                
            }
        })
    }

    
    override func viewDidLoad() {
        //print(uid);
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
