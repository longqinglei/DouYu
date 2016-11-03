//
//  AdsModel.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/19.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

class AdsModel: NSObject {
    //标题
    var title:String = ""
    //展示的图片
    var pic_url:String = ""
    //主播信息对应的字典
    var room:[String :NSObject]? {
        didSet{
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    //主播信息对应的对象
    var anchor: AnchorModel?
    
    //// MARK: - 重写构造函数
    override init(){
    }
    
    // MARK: - 自定义构造函数
    init(dict:[String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
        
    }

}

// MARK: - 监听值的改变
extension AdsModel {
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
