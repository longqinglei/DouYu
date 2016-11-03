//
//  NSDate-extension.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/15.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
        
    }
}
