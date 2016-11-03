//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/15.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

class RecommendViewModel :BaseViewModel {
    // MARK: - 定义懒加载属性
    lazy var adsModels:[AdsModel] = [AdsModel]()      //广告的数组
    fileprivate var prettyGroup:GameGroup = GameGroup() //颜值的数组
    fileprivate var hotGtoup:GameGroup = GameGroup()    //最热的数组
}
// MARK: - 首页界面网络请求
extension RecommendViewModel {
    // 请求无线轮播的数据
    func requestHaderViewData(finish:@escaping () ->()) {
        let netGroup = DispatchGroup()
        self.requestAdsData(netGroup: netGroup)
        netGroup.notify(queue: DispatchQueue.main) {
            finish()
        }
    }
    
    func requestData(finish:@escaping () -> ()) {
        let netGroup = DispatchGroup()
        // 1 请求第一部分推荐数据
        self.requestHotData(netGroup: netGroup)
        // 2 请求第二部分颜值数据
        self.requestPrettyData(netGroup: netGroup)
        // 3  请求后面部分游戏数据
        self.requestGameData(netGroup: netGroup)
        // 4 等所有网络请求完成,整合数据
        netGroup.notify(queue: DispatchQueue.main) {
            self.gameGroups.insert(self.prettyGroup, at: 0)
            self.gameGroups.insert(self.hotGtoup, at: 0)

            finish()
        }
    }
    
    //请求最热数据
    fileprivate func requestHotData(netGroup:DispatchGroup){
        netGroup.enter()
        NetworkHelper.requestData(type: .GET, URLString: DYZBIP+DYHomeRecommendHotHttp,parameters: ["aid":"ios","client_sys":"ios","time":NSDate.getCurrentTime()]) { (response) in
            // 1 判断网络请求是否成功
            if (response.error != nil) {
                print("获取最热信息失败")
                return
            }
            // 2 判断json解析是否成功 如果成功转成字典 如果不成功数据解析失败
            guard let resultDict = response.jsonData as? [String:NSObject] else{
                print("最热信息解析失败")
                return
            }
            // 3 根据data该key 获取数组
            guard let dataArr:[[String:NSObject]] = resultDict["data"] as? [[String : NSObject]] else{ return }
            
            // 4 获取data数据中的房间信息
            self.hotGtoup.tag_name = "最热"
            self.hotGtoup.icon_name = "columnHotIcon"
            self.hotGtoup.room_list = dataArr as [[String:NSObject]]
            netGroup.leave()
        }
    }
    
    //请求颜值数据
    fileprivate func requestPrettyData(netGroup:DispatchGroup){
        netGroup.enter()
        NetworkHelper.requestData(type: .GET, URLString: DYZBIP+DYHomeRecommendPrettyHttp,parameters: ["limit":"4","client_sys":"ios","offset":"0"]) { (response) in
            // 1 判断网络请求是否成功
            if (response.error != nil) {
                print("获取颜值信息失败")
                return
            }
            // 2 判断json解析是否成功 如果成功转成字典 如果不成功数据解析失败
            guard let resultDict = response.jsonData as? [String:NSObject] else{
                print("颜值信息解析失败")
                return
            }
            // 3 根据data该key 获取数组
            guard let dataArr:[[String:NSObject]] = resultDict["data"] as? [[String : NSObject]] else{ return }
            
            // 4 获取data数据中的房间信息
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "columnYanzhiIcon"
            self.prettyGroup.room_list = dataArr as [[String:NSObject]]
            netGroup.leave()
        }
    }
    
    //请求其他游戏数据
    fileprivate func requestGameData(netGroup:DispatchGroup){
        netGroup.enter()
        loadGameData(isGroup: true, type: .GET, URLString: DYZBIP+DYHomeRecommendGameHttp, parameters: ["aid":"ios","client_sys":"ios","limit":"4","time":NSDate.getCurrentTime()]) {
            netGroup.leave()
        }
    }
    
    fileprivate func requestAdsData(netGroup:DispatchGroup){
        netGroup.enter()
        NetworkHelper.requestData(type: .GET, URLString: DYZBIP + DYHomeRecommendAdsHttp, parameters: ["version":"2.303"]) { (response) in
            // 1 判断网络请求是否成功
            if (response.error != nil) {
                print("获取广告信息失败")
                return
            }
            // 2 判断json解析是否成功 如果成功转成字典 如果不成功数据解析失败
            guard let resultDict = response.jsonData as? [String:NSObject] else{
                print("广告信息解析失败")
                return
            }
            // 3 根据data该key 获取数组
            guard let dataArr:[[String:NSObject]] = resultDict["data"] as? [[String : NSObject]] else{ return }
            // 4 遍历数组 获取字典 并且将字典转成模型对象
            for dict in dataArr {
                let adsModel = AdsModel(dict: dict)
                self.adsModels.append(adsModel)
            }
            netGroup.leave()
        }
    }
}

