//
//  GameGroup.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/15.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

class GameGroup: BaseGameModel {
    //该组的房间信息
    var room_list: [[String : NSObject]]? {
        didSet{
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    //组显示的图标
    var icon_name :String = "home_header_normal"
    //主播房间的详细信息的数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()

}


