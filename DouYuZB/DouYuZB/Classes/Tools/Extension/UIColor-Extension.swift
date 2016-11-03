//
//  UIColor-Extension.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/13.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit


extension UIColor {
    
    convenience init(R:CGFloat, G:CGFloat, B:CGFloat) {
        self.init(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: 1)
    }
    
    class func randomColor() -> UIColor {
        return  UIColor(R: CGFloat(arc4random_uniform(255)), G: CGFloat(arc4random_uniform(255)), B: CGFloat(arc4random_uniform(255)))
    }
}
