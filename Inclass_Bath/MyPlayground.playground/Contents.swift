//: Playground - noun: a place where people can play

import Cocoa
let ss="aaaabc/nsdasdsad"
var size = CGRect();
var size2 = CGSize();
size = ss.boundingRectWithSize(size2, options: NSStringDrawingOptions.UsesFontLeading, attributes: nil, context: nil);

print(size.height)



