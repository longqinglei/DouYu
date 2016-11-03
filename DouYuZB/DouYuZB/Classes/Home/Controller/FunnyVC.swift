//
//  FunnyVC.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/25.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

fileprivate let kViewMargin : CGFloat = 8

class FunnyVC: BaseAnchorVC {
    
    //定义属性
    fileprivate lazy var funyVM :FunnyViewModel = FunnyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension FunnyVC {
    override func setUI() {
        super.setUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //取消组的头视图
        layout.headerReferenceSize = CGSize.zero
        //设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kViewMargin, left: 0, bottom: 0, right: 0)
    }
}

extension FunnyVC {
    override func requestData() {
        //给父类设置数据
        baseVM = funyVM
        //刷新数据
        self.funyVM.loadFunnyData {
            self.collectionView.reloadData()
            
            self.finishRequestData()
        }
    }
}

