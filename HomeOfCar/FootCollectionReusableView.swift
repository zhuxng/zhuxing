//
//  FootCollectionReusableView.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/8/12.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

class FootCollectionReusableView: UICollectionReusableView {
 
    //头脚视图的复用视图，在上面定制一个用来显示图片的视图
    var button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        button.frame = CGRectMake(0, 0, screenWidth, 150)
        self.addSubview(button)
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
