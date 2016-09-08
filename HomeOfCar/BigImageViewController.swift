//
//  BigImageViewController.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/8/13.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

class BigImageViewController: UIViewController,UIGestureRecognizerDelegate,UIScrollViewDelegate {
    
    var imageView = UIImageView()
    var model: ImageModel!
    var dataArray = [ImageModel]()
    var scrollView = UIScrollView()
    var index: Int!
    let forestr = "http://files.webcars.com.cn"
    override func viewDidLoad() {
        super.viewDidLoad()
        
//       interactivePopGestureRecognizer: 手势识别器负责弹出视图控制器导航堆栈的顶部
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(BigImageViewController.back))
        self.view.addGestureRecognizer(tap)
        
        
        scrollView = UIScrollView(frame: self.view.frame)
        scrollView.center = self.view.center
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        let num = CGFloat( dataArray.count )
        scrollView.contentSize = CGSizeMake(num * screenWidth, 0)
        for i in 0 ..< dataArray.count {
            
            let sc = UIScrollView(frame: CGRectMake(CGFloat(i) * screenWidth,0,screenWidth,screenHeigth))
            
            sc.contentSize = CGSizeMake(screenWidth,0 )
            sc.delegate = self
            //最小缩放尺度
            sc.maximumZoomScale = 2
            sc.minimumZoomScale = 1
            
            sc.tag = 20 + i
            
            let imageView = UIImageView(frame: CGRectMake(0,0,screenWidth - 20 , 300))
            imageView.center = self.view.center
            imageView.sd_setImageWithURL(NSURL(string:forestr + dataArray[i].PhotoUrl), placeholderImage: UIImage(named: "iconfont-pengyouquan"))
            sc.addSubview(imageView)
            scrollView.addSubview(sc)
            imageView.tag = i + 10
        }
        self.view.addSubview(scrollView)
        scrollView.contentOffset = CGPointMake(CGFloat( index ) * screenWidth , 0)
        
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        let myimageView =  scrollView.subviews[0]
        
        return myimageView
        
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        let i = Int( self.scrollView.contentOffset.x / screenWidth ) + 10
        if let imageView = scrollView.viewWithTag(i) {
            imageView.center.y = scrollView.bounds.midY
        }
        
        
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        
        if scale == 1 {
            self.scrollView.scrollEnabled = true
        } else {
            self.scrollView.scrollEnabled = false
        }
        
    }
    
    func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}
