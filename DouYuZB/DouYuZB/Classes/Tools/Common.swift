//
//  Common.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/13.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

// MARK: - 常量
let kStatusBarH :CGFloat = 20                   //状态栏高度
let kNavigationBarH:CGFloat = 44                //导航栏高度
let KTabBarH:CGFloat = 49                       //标签栏高度
let kScreenW:CGFloat = UIScreen.main.bounds.size.width      //屏幕宽度
let kScreenH:CGFloat = UIScreen.main.bounds.size.height     //屏幕高度


// MARK: - 网络
let DYZBIP = "http://capi.douyucdn.cn/api" //服务器地址
//首页  
//===========推荐================
let DYHomeRecommendGameHttp = "/v1/getHotCate"           //首页推荐游戏数据
let DYHomeRecommendPrettyHttp = "/v1/getVerticalRoom"    //首页推荐颜值数据
let DYHomeRecommendHotHttp = "/v1/getbigDataRoom"        //首页推荐最热数据
let DYHomeRecommendAdsHttp = "/v1/slide/6"               //首页推荐广告无限轮播数据
//===========游戏=================
let DYHomeGameAllGameHttp = "/v1/getColumnDetail"        //首页游戏全部游戏数据
//===========娱乐=================
let DYHomeAmuseGameHttp = "/v1/getHotRoom/2"             //首页游戏全部游戏数据
//===========趣玩=================
let DYHomeFunnyHttp = "/v1/getColumnRoom/3"             //首页游戏全部游戏数据
