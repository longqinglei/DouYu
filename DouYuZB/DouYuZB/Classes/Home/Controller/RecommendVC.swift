//
//  RecommendVC.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/15.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

// MARK: - 定义常量
fileprivate let kItemMargin:CGFloat = 10
fileprivate let kNormalItemW:CGFloat = (kScreenW - kItemMargin * 3) / 2
fileprivate let kPrettyItemH:CGFloat = kNormalItemW * 4 / 3
fileprivate let kHeaderViewH:CGFloat = 40

fileprivate let kNormalItemH:CGFloat = kNormalItemW * 3 / 4
fileprivate let kAdsViewH:CGFloat = kScreenW / 8 * 3
fileprivate let kGameViewH:CGFloat = 80

fileprivate let kNormalItem = "kNormalItem"
fileprivate let kPrettyItem = "kPrettyItem"
fileprivate let kRecommentHeaderView = "kRecommentHeaderView"

class RecommendVC: BaseAnchorVC {
    // 定义懒加载属性
    fileprivate lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    fileprivate lazy var recommendAdsView:RecommendAdsView = {
        let adsView = RecommendAdsView.creatAdsView()
        adsView.frame = CGRect(x: 0, y: -(kAdsViewH + kGameViewH), width: kScreenW, height: kAdsViewH)
        return adsView
    }()
    fileprivate lazy var recommendGameView:RecommendGameView = {
        let gameView = RecommendGameView.creatGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()

}

// MARK: - 设置UI界面内容
extension RecommendVC {
    override func setUI() {
        // 调用父类
        super.setUI()
        //添加collectionView
        self.view.addSubview(collectionView)
        //添加adsView
        collectionView.addSubview(recommendAdsView)
        //添加gameview
        collectionView.addSubview(recommendGameView)
        //设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kAdsViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 请求数据
extension RecommendVC {
    override func requestData() {
        // 给baseVM赋值
        baseVM = recommendVM
        
        //请求游戏数据
        recommendVM.requestData {
            // 1 刷新collectionView
            self.collectionView.reloadData()
            
            var groups = self.recommendVM.gameGroups
            // 移除前两个数据
            groups.removeFirst()
            groups.removeFirst()
            //添加最后一组更多的数据
            let gameGroup = GameGroup()
            gameGroup.tag_name = "更多"
            groups.append(gameGroup)
            // 2 把数据给gameview
            self.recommendGameView.groups = groups
            
            self.finishRequestData()
        }
        //请求广告数据
        recommendVM.requestHaderViewData {
            self.recommendAdsView.adsViews = self.recommendVM.adsModels
        }
    }
}

extension RecommendVC : UICollectionViewDelegateFlowLayout{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            // 取出颜值cell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyItem, for: indexPath) as! CollectionViewPrettyCell
            
            // 设置数据
            prettyCell.anchor = recommendVM.gameGroups[indexPath.section].anchors[indexPath.item]
            
            return prettyCell
            
        }else{
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW , height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}
