//
//  MainTabBarController.swift
//  DouYuZB
//
//  Created by longqinglei on 16/10/12.
//  Copyright © 2016年 龙青磊. All rights reserved.
//

import UIKit


class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.addChildVC(name: "Home")
        self.addChildVC(name: "Live")
        self.addChildVC(name: "Follow")
        self.addChildVC(name: "Profile")
    }
    
    func addChildVC(name:String) {
        let vc = UIStoryboard(name:name, bundle:nil).instantiateInitialViewController()!
        self.addChildViewController(vc)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
