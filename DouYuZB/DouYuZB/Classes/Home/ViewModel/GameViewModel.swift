//
//  GameViewModel.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/20.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

class GameViewModel {
    
    lazy var games : [GameModel] = [GameModel]()

}
// MARK: - 请求数据
extension GameViewModel {
    //请求全部游戏数据
    func requestAllGameData(finish : @escaping () -> ())  {
        NetworkHelper.requestData(type: .GET, URLString: DYZBIP+DYHomeGameAllGameHttp, parameters: ["shortName":"game"]) { (response) in
            if (response.error != nil) {
                print("获取全部游戏信息失败")
                return
            }
            // 2 判断json解析是否成功 如果成功转成字典 如果不成功数据解析失败
            guard let resultDict = response.jsonData as? [String:Any] else{
                print("全部游戏信息解析失败")
                return
            }
            // 3 根据data该key 获取数组
            guard let dataArr:[[String:NSObject]] = resultDict["data"] as? [[String : NSObject]] else{ return }
            // 4 获取data数据中的游戏信息
            for dict in dataArr {
                self.games.append(GameModel(dict: dict))
            }
            // 5 完成回调
            finish()
        }
    }
}
