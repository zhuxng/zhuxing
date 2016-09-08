//
//  MyTableBarControllerViewController.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/7/29.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

class MyTableBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = HomeViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        
        let carVC = CarRootViewController()
        let carNav = UINavigationController(rootViewController: carVC)
        
        
        let forumVC = ForumViewController()
        let forumNav = UINavigationController(rootViewController: forumVC)
        
        let myVC = MyViewController()
        let myNav = UINavigationController(rootViewController: myVC)
        
        
        let navArray = [homeNav, carNav, forumNav, myNav]
        
        viewControllers = navArray
        
        
        let titleArray = ["首页","汽车","论坛","我的"]
        let unselectedImageArray = ["iconfont-shouyeshouye","iconfont-qiche","iconfont-luntan","iconfont-wode"]
        let selectedImageArray = ["iconfont-shouyeshouye-2","iconfont-qiche-2","iconfont-luntan-2","iconfont-wode-2"]
        
        for i in 0 ..< navArray.count {
            
            let nav = navArray[i]
            nav.tabBarItem.title = titleArray[i]
            
            let unselectedImage = UIImage(named: selectedImageArray[i])
            nav.tabBarItem.image = unselectedImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            
            
            let selectedImage = UIImage(named: unselectedImageArray[i])
            nav.tabBarItem.image = selectedImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            
            
        }
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.RGBA(136, 216, 250)], forState: .Selected)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
