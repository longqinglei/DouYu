//
//  CollectionViewPrettyCell.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/15.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewPrettyCell: CollectionViewBaseCell {
    override var anchor:AnchorModel? {
        didSet{
            super.anchor = anchor
            //设置地点label
            locationLabel.text = anchor?.anchor_city
        }
    }
    
    @IBOutlet weak var locationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
