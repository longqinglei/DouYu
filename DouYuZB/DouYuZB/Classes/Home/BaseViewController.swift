//
//  BaseViewController.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/25.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    // 定义属性
    var contentView : UIView?
    // 懒加载属性
    fileprivate lazy var imageView : UIImageView = {[unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named:"img_loading_1")!,UIImage(named:"img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setUI()
    }
}

extension BaseViewController {
    func setUI() {
        // 1. 隐藏内容view
        contentView?.isHidden = true
        // 2. 添加动画
        view.addSubview(imageView)
        // 3. 让imageview执行动画
        imageView.startAnimating()
        // 4. 设置view的背景颜色
        view.backgroundColor = UIColor(R: 250, G: 250, B: 250)
        
    }
    
    func finishRequestData() {
        self.contentView?.isHidden = false
        imageView.isHidden = true
        imageView.stopAnimating()
    }
}
