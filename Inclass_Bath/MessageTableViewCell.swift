//
//  MessageTableViewCell.swift
//  Inclass_Bath
//
//  Created by Yu Shao on 16/7/22.
//  Copyright © 2016年 Yu Shao. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    @IBOutlet weak var textLabel1: UILabel!
        {
        didSet
        {
            textLabel1.layer.cornerRadius = 8
            textLabel1.layer.backgroundColor = UIColor.orangeColor().CGColor
        }
    }
    @IBOutlet weak var textLabel2: UILabel!
        {
        didSet
        {
            textLabel2.layer.cornerRadius = 8
            textLabel2.layer.backgroundColor = UIColor.lightGrayColor().CGColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

