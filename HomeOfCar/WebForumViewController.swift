//
//  WebForumViewController.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/8/19.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

class WebForumViewController: RootViewController {
    
    var urlstr: String!
    
    var webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLable?.text = "详情"
        leftButton?.addTarget(self, action: #selector(WebForumViewController.back), forControlEvents: .TouchDown)
        leftButton?.setImage(UIImage(named: "返回2"), forState: .Normal)
        
        
        webView = UIWebView(frame: self.view.bounds)
        let url = NSURL(string: urlstr)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        self.view.addSubview(webView)
        
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    
}