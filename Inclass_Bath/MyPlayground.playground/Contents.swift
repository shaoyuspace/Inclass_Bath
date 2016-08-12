//: Playground - noun: a place where people can play

import Cocoa
 let Time_Start = "19:18"
let Time_End="0:40"

let Time_Start_mins_int:Int?=Int((Time_Start as NSString).substringFromIndex(Time_Start.characters.count-2));

let Time_End_mins_int:Int?=Int((Time_End as NSString).substringFromIndex(Time_End.characters.count-2));

let Time_Start_hours_int:Int?=Int((Time_Start as NSString).substringToIndex(Time_Start.characters.count-3))

let Time_End_hours_int:Int?=Int((Time_End as NSString).substringToIndex(Time_End.characters.count-3))


