//
//  RootViewController.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/7/29.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit


func alert(VC:UIViewController) {
    let alert = UIAlertController(title: "提示", message: "网络好像开小差了", preferredStyle:.Alert)
    let ok = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil)
    alert.addAction(ok)
    VC.presentViewController(alert, animated: true, completion: nil)
}


class RootViewController: UIViewController {
    
    var titleLable: UILabel?
    var leftButton: UIButton?
    var rightBUtton: UIButton?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.translucent = false
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.RGBA(186, 219, 241)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        
        
        titleLable = Factory.createLabelWith(CGRectMake(0, 0, 44, 44), text: "", font: UIFont.systemFontOfSize(20), textAlignment: .Center, textColor: UIColor.whiteColor())
        navigationItem.titleView = titleLable
        
        leftButton = Factory.createButtonWith(CGRectMake(0, 0, 28, 28), type: UIButtonType.Custom, title: "", titleColor: UIColor.whiteColor(), targate: nil, imageName: "", action: nil, backgroundImageName: "")
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton!)
        
        rightBUtton = Factory.createButtonWith(CGRectMake(0, 0, 36, 36), type: UIButtonType.Custom, title: "", titleColor: UIColor.whiteColor(), targate: nil, imageName: "", action: nil, backgroundImageName: "")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBUtton!)
        
    }
    
    func addLeftTarget(selector: Selector) {
        leftButton?.addTarget(self, action: selector, forControlEvents: .TouchUpInside)
    }
    
    func addRigthTarget(selector: Selector) {
        rightBUtton?.addTarget(self, action: selector, forControlEvents: .TouchUpInside)
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
