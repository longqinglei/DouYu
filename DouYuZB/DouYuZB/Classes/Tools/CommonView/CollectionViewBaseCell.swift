//
//  CollectionViewBaseCell.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/18.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewBaseCell: UICollectionViewCell {
    // 定义控件属性
    @IBOutlet weak var roomImageView: UIImageView!
    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    //定义数据模型
    var anchor:AnchorModel? {
        didSet{
            guard let anchor = anchor else { return }
            //设置在线人数
            if anchor.online > 10000 {
                let bigOnline = anchor.online / 1000
                onlineLabel.text = "\(Double(bigOnline)/Double(10.0))万"
            }else{
                onlineLabel.text = "\(anchor.online)"
            }
            //设置主播昵称
            nickNameLabel.text = anchor.nickname
            //设置房间图片
            roomImageView.kf.setImage(with: NSURL(string: (anchor.vertical_src)) as! URL)
        }
    }
}
