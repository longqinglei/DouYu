//
//  PageContentView.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/12.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView:PageContentView,progress:CGFloat, currentIndex:Int,targetIndex:Int)
}

private let contentCellID = "contentCellID"

class PageContentView: UIView {
    // MARK: -定义属性
    fileprivate var childVCs:[UIViewController]
    fileprivate weak var parentVC:UIViewController?
    fileprivate var starOffsetX:CGFloat = 0
    fileprivate var isForbidScrollDelegate:Bool = false
    weak var delegate:PageContentViewDelegate?
    
    // MARK: -懒加载属性
    fileprivate lazy var collentionView:UICollectionView = {[weak self] in
        // 1 创建layout
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2 创建uicollectionview
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.frame = (self?.bounds)!
        collectionView.dataSource = self
        collectionView.delegate = self as UICollectionViewDelegate?
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
    }()
    
    // MARK: -自定义构造函数
    init(frame: CGRect, childVCs: [UIViewController], parentVC:UIViewController) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame:frame)
        
        //设置UI
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI界面
extension PageContentView {
    fileprivate func setUI(){
        
        // 1. 将所有的子控制器添加到父控制器中
        for childVC in childVCs {
            parentVC?.addChildViewController(childVC)
        }
        // 2. 添加UICollectionView,用于在Cell中存放控制器的View
        addSubview(collentionView)
        
    
    }
}
// MARK: - 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        // 1 创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        // 2 给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVC = childVCs[indexPath.row]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
    
        return cell
    }
}
// MARK: - 遵守UICollectionViewDelegate
extension PageContentView:UICollectionViewDelegate {
    // 1 将要开始滑动调用的方法
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        starOffsetX = scrollView.contentOffset.x
    }
    // 开始滑动后调用的方法
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        //判断是否是点击事件
        if isForbidScrollDelegate { return }
        // 1 定义需要的数据
        var progresss:CGFloat = 0
        var currentIndex:Int = 0
        var targetIndex:Int = 0
        
        let offsetX = scrollView.contentOffset.x
        
        if  offsetX > starOffsetX  { //向左滑
            // 1 计算滑动的比例
            progresss = (offsetX / kScreenW) - floor(offsetX / kScreenW)
            // 2 计算currentIndex 
            currentIndex = Int(offsetX / kScreenW)
            // 3 计算targetIndex
            targetIndex = currentIndex + 1
            if targetIndex > childVCs.count {
                targetIndex = targetIndex - 1
            }
            // 4 如果完全滑过去
            if offsetX - starOffsetX == kScreenW || offsetX - starOffsetX < 1 {
                progresss = 1
                targetIndex = currentIndex
            }
        }else{  //向右滑
            // 1 计算滑动的比例
            progresss = 1 - ((offsetX / kScreenW) - floor(offsetX / kScreenW))
            
            // 2 计算targetIndex
            targetIndex = Int(offsetX / kScreenW)
            
            // 3 计算currentIndex
            currentIndex = targetIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = targetIndex - 1
            }
            // 4 如果完全滑过去
            if starOffsetX - offsetX == kScreenW{
                progresss = 1
                currentIndex = targetIndex
            }
        }
        //通知代理
        delegate?.pageContentView(contentView: self, progress: progresss, currentIndex: currentIndex, targetIndex: targetIndex)
    }
}
// MARK: -  对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex:Int)  {
        //记录需要禁止滚动的代理方法
        isForbidScrollDelegate = true
        //
        collentionView.setContentOffset(CGPoint(x: CGFloat(currentIndex) * collentionView.frame.width, y: 0), animated: true)
    }
}

