//
//  HomeRecommendHeaderView.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/15.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

class HomeRecommendHeaderView: UICollectionReusableView {
    
    // MARK: - 定义模型属性
    var group:GameGroup? {
        didSet{
            guard (group != nil)  else { return }
            self.iconImageView.image = UIImage(named: (group?.icon_name)!)
            self.titleLabel.text = group?.tag_name
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension HomeRecommendHeaderView {
    class func creatHomeRecommendHeaderView() -> HomeRecommendHeaderView {
        return Bundle.main.loadNibNamed("HomeRecommendHeaderView", owner: nil, options: nil)?.first as! HomeRecommendHeaderView
    }
}
