//
//  HomeVC.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/12.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit
import Alamofire

fileprivate let kTitleViewH :CGFloat = 40

class HomeVC: UIViewController {
    
    // 懒加载属性
    fileprivate lazy var pageTitleView:PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: 40)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView:PageContentView = { [weak self] in
        // 1. 确定内容视图的frame
        let contentViewH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - KTabBarH
        let contentViewFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentViewH)
        // 2. 确定内容视图内的所有子控制器
        var childVCs = [UIViewController]()
        childVCs.append(RecommendVC())
        childVCs.append(GameVC())
        childVCs.append(AmuseVC())
        childVCs.append(FunnyVC())
        let contentView = PageContentView(frame: contentViewFrame, childVCs: childVCs, parentVC: self!)
        contentView.delegate = self
        return contentView
    }()
    // 系统的回掉函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI
        self.setUI()
        
    }

}
// MARK: - 设置UI
extension HomeVC{
    // 1  设置导航条
    fileprivate func setUI(){
        //取消scrollow的内填充
        automaticallyAdjustsScrollViewInsets = false
        //1.1 设置导航条
        self.setTabBarItem()
        
        //1.2 添加titleView
        view.addSubview(pageTitleView)
        
        //1.3 添加contentView
        view.addSubview(pageContentView)
    }
    
    // 2 设置导航条
    fileprivate func setTabBarItem(){
        // 1 设置导航条背景颜色
        self.navigationController?.navigationBar.barTintColor =
            UIColor.orange
        
        // 2 设置左边的item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "homeLogoIcon")
        
        // 3 设置导航右边的item
        let size:CGSize = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "viewHistoryIcon", hightImageName: "viewHistoryIconHL", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "scanIcon", hightImageName: "scanIconHL", size: size)
        let searchItem = UIBarButtonItem(imageName: "searchBtnIcon", hightImageName: "searchBtnIconHL", size: size)
        self.navigationItem.rightBarButtonItems = [searchItem,qrcodeItem,historyItem]
    }
}

// MARK: - 遵守PageTitleViewDelegate协议
extension HomeVC : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

// MARK: - 遵守PageContentViewDelegate协议
extension HomeVC : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, currentIndex: Int, targetIndex: Int) {
        pageTitleView.scrollChangeAction(progress: progress, currentIndex: currentIndex, targetIndex: targetIndex)
    }
}
