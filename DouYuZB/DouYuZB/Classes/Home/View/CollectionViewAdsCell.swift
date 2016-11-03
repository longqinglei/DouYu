//
//  CollectionViewAdsCell.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/19.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

class CollectionViewAdsCell: UICollectionViewCell {
    
    // 定义属性
    var adsModel:AdsModel? {
        didSet{
            imageView.kf.setImage(with: NSURL(string: (adsModel?.pic_url)!) as! URL)
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
