//
//  AnchorModel.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/17.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    //房间ID
    var room_id :Int = 0
    //房间图片
    var vertical_src :String = ""
    //判读是手机直播还是电脑直播 0 电脑  1 手机
    var isVertical : Int = 0
    //房间名称
    var room_name :String = ""
    //主播昵称
    var nickname: String = ""
    //在线观看人数
    var online:Int = 0
    //所在城市
    var anchor_city:String = ""
    

    init(dict : [String: NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }

}

// MARK: - 监听kvc赋值
extension AnchorModel {
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
