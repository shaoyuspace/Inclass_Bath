//
//  AddtimetableViewController.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/7/25.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//

import UIKit
import EventKit

class AddtimetableViewController: UIViewController {
    @IBAction func Click(sender: AnyObject) {
        let eventStore:EKEventStore = EKEventStore()
        eventStore.requestAccessToEntityType(.Event, completion: {
            granted, error in
            if (granted) && (error == nil) {
                print("granted \(granted)")
                print("error  \(error)")
                
                
                let cans = eventStore.calendarsForEntityType(EKEntityType.Event)
                
                var cans1 = [EKCalendar]();
                for can in cans
                {
                    //print(can.title)
                    if(can.title == "University of Bath personal timetable - ys823")
                    {
                        
                    //print("yes")
                    cans1.append(can)
                    }

                }
                
       
                
                
                if(cans1.count != 0)
                {
                    
                    // 获取所有的事件（前后90天）
                    let startDate=NSDate().dateByAddingTimeInterval(-3600*24*180)
                    let endDate=NSDate().dateByAddingTimeInterval(3600*24*10)
                    let predicate2 = eventStore.predicateForEventsWithStartDate(startDate,
                        endDate: endDate, calendars: cans1)
                    
                    let eV = eventStore.eventsMatchingPredicate(predicate2) as [EKEvent]!
                    
                    
                    var class_List = [Class_Time]()
                    if eV != nil {
                        for i in eV {
                            print(i.location);
                            let ct = Class_Time(name: i.title,stime: i.startDate,etime: i.endDate,location:i.location!as String);
                         //print(ct.name);
                        
                    class_List.append(ct);
                            

                        }
                    }
                    Localfiles.delete("ys823.plist.plist")
                    Localfiles.delete("test_ys823.plist")
                    Localfiles.savetimetable("ys824", clist: class_List)
                    Localfiles.loadData("ys824");
                    //Localfiles.delete("ys823.plist")
                }
                else
                {
                    
                    print("can not find");
                    
                }

            }
        })
        
    }

    override func viewDidLoad() {
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
