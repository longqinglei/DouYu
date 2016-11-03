//
//  CollectionViewGameCell.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/19.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

class CollectionViewGameCell: UICollectionViewCell {
    // 定义控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    // 定义数据模型
    var baseGame : BaseGameModel? {
        didSet{
            
            titleLabel.text = baseGame?.tag_name
            iconImageView.kf.setImage(with: NSURL(string: (baseGame!.icon_url)) as! URL, placeholder: UIImage(named: "recommentmore"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
