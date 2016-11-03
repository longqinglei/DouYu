//
//  GameVC.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/20.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

//定义常量
fileprivate let kItemCell = "kItemCell"
fileprivate let kGroupHeaderView = "kGroupHeaderView"
fileprivate let kItemMargin : CGFloat = 10
fileprivate let kItemW : CGFloat = (kScreenW - 2 * kItemMargin) / 3
fileprivate let kItemH : CGFloat = kItemW * 5 / 5
fileprivate let kGroupHeaderViewH : CGFloat = 40
fileprivate let kHeaderGameViewH : CGFloat = 90


class GameVC: BaseViewController {
    // 定义懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        // 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kGroupHeaderViewH)
        // 创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register( UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kItemCell)
        collectionView.register(UINib(nibName:"HomeRecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kGroupHeaderView)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        return collectionView
    }()
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var topHeaderView : HomeRecommendHeaderView = {
        let topHeaderView = HomeRecommendHeaderView.creatHomeRecommendHeaderView()
        topHeaderView.frame = CGRect(x: 0, y: -(kGroupHeaderViewH + kHeaderGameViewH), width: kScreenW, height: kGroupHeaderViewH)
        topHeaderView.titleLabel.text = "常用"
        topHeaderView.iconImageView.image = UIImage(named: "Img_orange")
        topHeaderView.moreBtn.isHidden = true
        return topHeaderView
    }()
    
    fileprivate lazy var headerGameView : RecommendGameView = {
        let headerGameView = RecommendGameView.creatGameView()
        headerGameView.frame = CGRect(x: 0, y: -kHeaderGameViewH, width: kScreenW, height: kHeaderGameViewH)
        return headerGameView
    }()

    override func viewDidLoad() {
        // 系统回调方法
        super.viewDidLoad()
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 设置UI界面
        setUI()
        
        //请求数据
        requestData()

    }

}

// MARK: - 设置UI界面
extension GameVC {
    override func setUI(){
        //给父类的view赋值
        contentView = collectionView
        //添加collectionView
        view.addSubview(collectionView)
        //添加顶部头视图
        collectionView.addSubview(topHeaderView)
        //添加常用游戏view
        collectionView.addSubview(headerGameView)
        //设置collectionView的偏移量
        collectionView.contentInset = UIEdgeInsets(top: kGroupHeaderViewH + kHeaderGameViewH, left: 0, bottom: 0, right: 0)
        //调用父类的方法
        super.setUI()
    }
}

// MARK: - 请求数据
extension GameVC {
    fileprivate func requestData(){
        self.gameVM.requestAllGameData {
            
            //展示全部游戏
            self.collectionView.reloadData()
            
            //展示常用数据
            self.headerGameView.groups = Array(self.gameVM.games[0..<10])
            
            self.finishRequestData()
        }
    }
}

extension GameVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //取出cell
        let game = self.gameVM.games[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kItemCell, for: indexPath) as! CollectionViewGameCell
        
        cell.baseGame = game
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kGroupHeaderView, for: indexPath) as! HomeRecommendHeaderView

        //给headerView设置属性
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }
}
