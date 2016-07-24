//
//  Message.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/7/22.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//

import Foundation.NSDate

class Message {
    let incoming: Bool
    let text: String
    let sentDate: NSDate
    var url = ""
    init(incoming: Bool, text: String, sentDate: NSDate) {
        self.incoming = incoming
        self.text = text
        self.sentDate = sentDate
    }
}
