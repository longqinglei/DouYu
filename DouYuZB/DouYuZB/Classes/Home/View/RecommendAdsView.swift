//
//  RecommendAdsView.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/18.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

fileprivate let kAdsCell = "kAdsCell"

class RecommendAdsView: UIView {
    
    //定义属性
    var adsTimer:Timer?  //定时器
    var adsViews: [AdsModel]? {
        didSet{
            guard let adsViews = adsViews else { return }
            // 1 刷新数据
            collectionView.reloadData()
            // 2 设置pageControl的个数
            pageControl.numberOfPages = adsViews.count 
            // 3 默认滚动到中间的某个位置
            let indexPath = NSIndexPath(item: (adsViews.count) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            // 4 添加定时器
            removeAdsTimer()
            addAdsTimer()
        }
    }
    
    
    // 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件的大小不随着父控件的大小改变而改变
        autoresizingMask = UIViewAutoresizing.flexibleLeftMargin
        //注册广告cell
        collectionView.register(UINib(nibName: "CollectionViewAdsCell", bundle: nil), forCellWithReuseIdentifier: kAdsCell)
    }
    
    override func layoutSubviews() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = self.bounds.size
        
    }
}


// MARK: - 定义一个快速创建的方法
extension RecommendAdsView {
    class func creatAdsView() -> RecommendAdsView{
        return Bundle.main.loadNibNamed("RecommendAdsView", owner: self, options: nil)?.first as! RecommendAdsView
    }
}

// MARK: - 遵守uicollectionViewDataSource
extension RecommendAdsView:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (adsViews?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAdsCell, for: indexPath) as! CollectionViewAdsCell
        
        let adsModel = adsViews![indexPath.item % (adsViews?.count)!]
        
        cell.adsModel = adsModel
                
        return cell
    }
}

// MARK: - 遵守UICollectionViewDelegate 
extension RecommendAdsView : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = collectionView.contentOffset.x + scrollView.bounds.width * 0.5
        let currentIndex = Int(offsetX / kScreenW)
        pageControl.currentPage = currentIndex % (adsViews?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeAdsTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addAdsTimer()
    }
}

// MARK: - 对定时器的操作方法
extension RecommendAdsView {
    fileprivate func addAdsTimer(){
        adsTimer = Timer(timeInterval: 5, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(adsTimer!, forMode: RunLoopMode.commonModes)
    }
    
    fileprivate func removeAdsTimer(){
        adsTimer?.invalidate()//从运行循环中移除
        adsTimer = nil
    }
    
    @objc fileprivate func scrollToNext(){
        //计算要滚动的距离
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.size.width
        //滚动到改位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
        
    }
}
