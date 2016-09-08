//
//  CarDetailModel2.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/8/19.
//  Copyright © 2016年 zhuxing. All rights reserved.
//


import UIKit

class CarDetailModel2: NSObject {
    var Engine = ""
    
    var VType = ""
    
    var EPS = ""
    
    var LWH = ""
    
    var Transmission = ""
    
    var CartType = ""
    
    var Displacement = ""
    
    var EPA = ""
    
    var Make = ""
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        if key == "L/W/H" {
            LWH = value as! String
        }
    }
    
    
}
