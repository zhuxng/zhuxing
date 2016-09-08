//
//  WebDetailViewController.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/8/12.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

class WebDetailViewController: RootViewController {
    
    var model = homeCarModel()
    var headerView = UIView()
    var webView = UIWebView()
    var imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        createNav()

        createUI()
        
    }
    
    func createNav() {
        titleLable?.text = "\(model.channelName!)详情"
        leftButton?.setImage(UIImage(named: "返回2"), forState: UIControlState.Normal)
        addLeftTarget(#selector(WebDetailViewController.backButtonClicked))
        
    }
    
    func backButtonClicked(){
        navigationController?.popViewControllerAnimated(true)
    }


    func createUI() {
        imageView = UIImageView(frame: CGRectMake(10, 10, screenWidth - 20, screenHeigth / 3 - 10))
        imageView.sd_setImageWithURL(NSURL(string: model.image!), placeholderImage: UIImage(named: "iconfont-pengyouquan"))
        imageView.backgroundColor = UIColor.yellowColor()
        headerView = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeigth / 3))
        self.headerView.addSubview(imageView)
        
        
        webView = UIWebView(frame: CGRectMake(0, screenHeigth / 3, screenWidth, screenHeigth ))
        
        let request = NSURLRequest(URL: NSURL(string: model.url!)!)
        webView.loadRequest(request)
        
        self.view.addSubview(webView)
        self.view.addSubview(headerView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
