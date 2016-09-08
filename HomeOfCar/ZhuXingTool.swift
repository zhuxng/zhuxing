//
//  ZhuXingTool.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/7/29.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import Foundation
let screenWidth = UIScreen.mainScreen().bounds.size.width


let screenHeigth = (UIScreen.mainScreen().bounds.size.height - 64)


extension UIColor {
    static func RGBA(red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) -> UIColor {
        
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)

    
    }
    static func mainColor() -> UIColor{
        return UIColor.RGBA(186, 219, 241)
    }
    
    
    
    
}
