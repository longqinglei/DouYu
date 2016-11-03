//
//  AmuseVC.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/21.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

fileprivate let kMenuViewH : CGFloat = 200

class AmuseVC: BaseAnchorVC {
    // 定义懒加载属性
    fileprivate lazy var amuseVM = AmuseViewModel()
    fileprivate lazy var amuseMenuView:AmuseMenuView = {
        let menuView:AmuseMenuView = AmuseMenuView.creatAmuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
    
}

// MARK: - 设置UI界面
extension AmuseVC {
    override func setUI() {
        super.setUI()
        
        collectionView.addSubview(amuseMenuView)
        
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 请求数据
extension AmuseVC {
    override func requestData(){
        // 1 给父类中的ViewModel赋值
        baseVM = amuseVM
        // 2 请求数据
        self.amuseVM.loadAmuseData {
            self.collectionView.reloadData()
            var tempGroup = self.amuseVM.gameGroups
            tempGroup.removeFirst()
            self.amuseMenuView.groups = tempGroup
            
            self.finishRequestData()
        }
    }
}


