//
//  GuidePageView.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/7/29.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

class GuidePageView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var scrollView: UIScrollView?
    var logInButton: UIButton?
    init(frame: CGRect, imageArray: NSArray) {
        super.init(frame: frame)
        scrollView = UIScrollView(frame: CGRectMake(0, 0, screenWidth, screenHeigth + 64))
        scrollView?.pagingEnabled = true
        scrollView?.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView!)
        
        scrollView?.contentSize = CGSizeMake(CGFloat(imageArray.count) * screenWidth, 0)
        for i in 0..<imageArray.count {
            let imageview = Factory.createImageView(CGRectMake(CGFloat(i) * screenWidth, 0, screenWidth, screenHeigth + 64), imageName: imageArray[i] as! String)
            imageview.userInteractionEnabled = true
            
            scrollView?.addSubview(imageview)
            
            if i == imageArray.count - 1 {
                logInButton = UIButton(frame: CGRectMake(90, screenHeigth - 112, 238, 60))
                logInButton?.layer.cornerRadius = 25
                logInButton?.clipsToBounds = true
//                logInButton?.setImage(UIImage(named: "Login"), forState: .Normal)
                logInButton?.setTitle("立刻体验", forState: .Application)

                imageview.addSubview(logInButton!)
            }
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
