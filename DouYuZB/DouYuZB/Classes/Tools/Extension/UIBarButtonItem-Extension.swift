//
//  UIBarButtonItem-Extension.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/12.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    convenience init(imageName:String, hightImageName:String = "", size:CGSize = CGSize.zero) {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        if !(hightImageName == "") {
            btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView : btn)
        
    }
}
