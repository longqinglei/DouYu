//
//  CollectionViewNormalCell.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/15.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewNormalCell: CollectionViewBaseCell {
    //定义控件属性
    @IBOutlet weak var roomNameLabel: UILabel!
    //重写监听方法
    override var anchor: AnchorModel?{
        didSet{
            super.anchor = anchor
            //设置房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

