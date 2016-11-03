//
//  RecommendGameView.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/19.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

fileprivate let kGameCell = "kGameCell"
fileprivate let kGameMargin: CGFloat = 10


class RecommendGameView: UIView {
    // 定义数据
    var groups: [BaseGameModel]? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = UIViewAutoresizing.flexibleLeftMargin
        
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCell)
        
        collectionView.contentInset = UIEdgeInsetsMake(0, kGameMargin - 5, 0, kGameMargin)
    }

}

// MARK: - 定义一个快速创建的类方法
extension RecommendGameView {
    
    class func creatGameView() -> RecommendGameView {
        let gameView = Bundle.main.loadNibNamed("RecommendGameView", owner: self, options: nil)?.first as! RecommendGameView
        return gameView 
    }
}

// MARK: - 遵守UICollectionDataSource  
extension RecommendGameView :UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //获取数据模型
        let group  = groups?[indexPath.item]
        // 获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCell, for: indexPath) as! CollectionViewGameCell
        cell.baseGame = group
        return cell
        
    }
}
