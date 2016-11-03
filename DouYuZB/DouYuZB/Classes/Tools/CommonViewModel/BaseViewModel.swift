//
//  BaseViewModel.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/24.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var gameGroups:[GameGroup] = [GameGroup]()
}

extension BaseViewModel {
    func loadGameData(isGroup : Bool, type : RequestType, URLString : String, parameters : [String :Any]? = nil, finish:@escaping () -> ()) {
        NetworkHelper.requestData(type: type, URLString: URLString, parameters: parameters) { (response) in
            // 1 判断网络请求是否成功
            if (response.error != nil) {
                print("获取娱乐游戏信息失败")
                return
            }
            // 2 判断json解析是否成功 如果成功转成字典 如果不成功数据解析失败
            guard let resultDict = response.jsonData as? [String:NSObject] else{
                print("娱乐游戏信息解析失败")
                return
            }
            // 3 根据data该key 获取数组
            guard let dataArr:[[String:NSObject]] = resultDict["data"] as? [[String : NSObject]] else{ return }
            // 4 遍历数组 获取字典 并且将字典转成模型对象
            
            if isGroup {
                for dict in dataArr {
                    self.gameGroups.append(GameGroup(dict: dict))
                }
            }else{
                let group = GameGroup()
                for dict in dataArr {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                self.gameGroups.append(group)
            }
            finish()
        }
    }
}
