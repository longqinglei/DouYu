//
//  AmuseMenuViewCell.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/25.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

fileprivate let MenuCellID = "MenuCellID"

class AmuseMenuViewCell: UICollectionViewCell {
    
    // 
    var groups:[GameGroup]? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: MenuCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: kScreenW / 4, height: collectionView.bounds.size.height / 2)
    }

}

extension AmuseMenuViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCellID, for: indexPath) as! CollectionViewGameCell
        let baseGame  = groups?[indexPath.item]
        cell.baseGame = baseGame
        cell.layer.masksToBounds = true
        return cell
        
    }
}
