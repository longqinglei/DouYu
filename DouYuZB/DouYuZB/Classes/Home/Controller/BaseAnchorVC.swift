//
//  BaseAnchorVC.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/24.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

fileprivate let kNormalItem = "kNormalItem"
fileprivate let kPrettyItem = "kPrettyItem"
fileprivate let kRecommentHeaderView = "kRecommentHeaderView"

fileprivate let kItemMargin:CGFloat = 10
fileprivate let kNormalItemH:CGFloat = kNormalItemW * 3 / 4
fileprivate let kNormalItemW:CGFloat = (kScreenW - kItemMargin * 3) / 2
fileprivate let kHeaderViewH:CGFloat = 40

class BaseAnchorVC: BaseViewController {
    
    // 定义属性 
    var baseVM:BaseViewModel!
    // 定义懒加载属性
    lazy var collectionView : UICollectionView = { [weak self] in
        // 1 创建布局layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) //每组的头视图的大小
        // 2 创建collectionView
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        //        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH - 64 - 49 - 40), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        //注册cell
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalItem)
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyItem)
        //注册组的头视图
        collectionView.register(UINib(nibName:"HomeRecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kRecommentHeaderView)
        return collectionView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置ui界面
        setUI()
        //请求数据
        requestData()
     }
}

// MARK: -  设置UI界面
extension BaseAnchorVC {
    override func setUI(){
        // 1 给父类中的内容view 的引用进行赋值
        contentView = collectionView
        // 2 添加collectionView
        view.addSubview(collectionView)
        // 3 调用父类
        super.setUI()
    }
}

// MARK: - 请求数据
extension BaseAnchorVC {
    func requestData(){
    }
}

// MARK: - 遵守UICollectionViewDataSource
extension BaseAnchorVC : UICollectionViewDataSource {
    //返回组的个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.baseVM.gameGroups.count
    }
    // 返回每组中item的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = baseVM.gameGroups[section]
        return group.anchors.count
    }
    //返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 取出模型
        let group  = baseVM.gameGroups[indexPath.section]
        let anchor = group.anchors[indexPath.row]
        //获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalItem, for: indexPath)
            as! CollectionViewNormalCell
        cell.anchor = anchor
        return cell
    }
    //返回组的头视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1 取出section的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kRecommentHeaderView, for: indexPath) as! HomeRecommendHeaderView
        
        // 2 取出模型
        headerView.group = baseVM.gameGroups[indexPath.section]
        return headerView
    }
//    //返回每组的头视图的高度
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
//        // 2 取出模型
//        let group = baseVM.gameGroups[section]
//        if group.anchors.count == 0 {
//            return CGSize(width: 0, height: 0)
//        }else{
//            return CGSize(width: kScreenW, height: kHeaderViewH)
//        }
//    }
    
}

// MARK: - 遵守UICollectionViewDelegate
extension BaseAnchorVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anchor = self.baseVM.gameGroups[indexPath.section].anchors[indexPath.item]
        
        anchor.isVertical == 0 ? pushNormalVC() : presentShowVC()
    }
    
    func presentShowVC() {
        let showVC = RoomShowVC()
        
        self.present(showVC, animated: true, completion: nil)
    }
    
    func pushNormalVC() {
        let normalVC = RoomNormalVC()
        self.navigationController?.pushViewController(normalVC, animated: true)
    }
}
