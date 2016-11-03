//
//  AmuseMenuView.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/25.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

fileprivate let MenuViewCellID = "MenuViewCellID"

class AmuseMenuView: UIView {
    
    // 定义数据 
    var groups:[GameGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    

    @IBOutlet weak var pageCintrol: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.register(UINib(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: MenuViewCellID)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = collectionView.bounds.size
    }
}

// MARK: -  快速创建的类方法
extension AmuseMenuView {
    class func creatAmuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

// MARK: -  遵守UICollectionViewDataSource 
extension AmuseMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil { return 0 }
        let pagecount = (groups!.count - 1) / 8 + 1
        pageCintrol.numberOfPages = pagecount
        return pagecount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuViewCellID, for: indexPath) as! AmuseMenuViewCell
        let starIndex = indexPath.item * 8
        var endIndex = indexPath.item * 8 + 8
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        cell.groups = Array(groups![starIndex...endIndex])
        return cell
    }
}

extension AmuseMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageCintrol.currentPage = Int(collectionView.contentOffset.x / collectionView.bounds.size.width)
    }
}
