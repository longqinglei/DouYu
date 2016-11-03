//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/12.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

// MARK: - 定义协议
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView:PageTitleView,selectedIndex index : Int)
}
// MARK: -定义常量
private let kScrollLineH:CGFloat = 2
private let kNormalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor:(CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {
    // MARK: - 定义属性
    fileprivate var titles:[String]
    fileprivate var currentLabelIndex:Int = 0
    weak var delegate : PageTitleViewDelegate?
    // MARK: - 懒加载属性
    fileprivate lazy var titleLabels:[UILabel] = [UILabel]()
    fileprivate lazy var scrollView:UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator  = false
        scroll.scrollsToTop = false
        scroll.bounces = false
        return scroll
    }()
    
    fileprivate lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
    // MARK: -自定义构造函数
    init(frame:CGRect, titles:[String]) {
        self.titles = titles
        
        super.init(frame:frame)
        
        //1 设置UI界面
        setUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - 设置UI界面
extension PageTitleView {
    fileprivate func setUI(){
        // 1. 设UIScrollow
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2. 添加title对应的label
        setUpTitleLabels()
        
        // 3. 添加底部的滚动条和底线
        setBottonMenuAndScrollLine()
    }
    
    private func setUpTitleLabels(){
        // 0 确定label的frame的值
        let labelW:CGFloat = bounds.size.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.size.height - kScrollLineH
        let labelY:CGFloat = 0
        for (index,title) in titles.enumerated() {
            
            // 1 创建label
            let label = UILabel()
    
            //2 设置label的属性
            label.text = title
            label.tag = index
            label.textColor = UIColor(R: kNormalColor.0, G: kNormalColor.1, B: kNormalColor.2)
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .center
            
            // 3 设置label的frame
            label.frame = CGRect(x: CGFloat(index) * labelW, y: labelY, width: labelW, height: labelH)
            
            // 4 讲label添加到label
            addSubview(label)
            titleLabels.append(label)
            
            // 5 给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setBottonMenuAndScrollLine(){
        // 1 添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.gray
        let lineH:CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.size.height - lineH, width: frame.size.width, height: lineH)
        addSubview(bottomLine)
        
        // 2 添加底部滑块
        //2.1 获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(R: kSelectColor.0, G: kSelectColor.1, B: kSelectColor.2)
        // 2.2 设置滑块的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
    }
}

// MARK: -  监听点击事件
extension PageTitleView {
    @objc fileprivate func titleLabelClick(tapGes:UITapGestureRecognizer){
        // 1 获取当前label
        guard let currentLabel = tapGes.view as? UILabel else { return }
        //判断点击的是不是同一个label
        let oldTag = currentLabel.tag
        if oldTag == currentLabelIndex { return }
        
        // 2 获取之前的label(之前要想办法保存之前label的下标值)
        let oldLabel = titleLabels[currentLabelIndex]
        
        // 3 切换文字的颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor(R: kNormalColor.0, G: kNormalColor.1, B: kNormalColor.2)
        
        // 4 滚动滑块位置发生改变
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = CGFloat(currentLabel.tag) * self.scrollLine.frame.width
        }
        
        // 5 保存当前显示的最新的label的下标值
        currentLabelIndex = currentLabel.tag
        
        // 6 通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentLabelIndex)
    }
    
}

// MARK: - 对外暴露的方法
extension PageTitleView {
    func scrollChangeAction(progress:CGFloat,currentIndex:Int,targetIndex:Int){
        print(progress,currentIndex,targetIndex)
        // 1 取出currentlabel 和 targetlabel
        let currentLabel = titleLabels[currentIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2 处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - currentLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = currentLabel.frame.origin.x + moveX
        
        // 3 颜色的渐变
         // 3.1 取出颜色变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        // 3.2 变化currentLabel 
        currentLabel.textColor = UIColor(R: kSelectColor.0 - colorDelta.0 * progress, G: kSelectColor.1 - colorDelta.1 * progress, B: kSelectColor.2 - colorDelta.2 * progress)
        targetLabel.textColor = UIColor(R: kNormalColor.0 + colorDelta.0 * progress, G: kNormalColor.1 + colorDelta.1 * progress, B: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4 记录最新的Index
        currentLabelIndex = targetIndex
        
    }
}
