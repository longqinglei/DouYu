//
//  BaseGameModel.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/20.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    //游戏名称
    var tag_name :String = ""
    //游戏的图标
    var icon_url :String = ""
    //重写构造方法
    override init() {
        
    }
    //定义构造方法
    init(dict: [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
