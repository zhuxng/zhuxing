//
//  ForumModel.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/8/19.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import Foundation
class ForumModel: NSObject {
    
    var url = ""
    
    var downs: Int = 0
    
    var id = ""
    
    var mtime: Int = 0
    
    var count: Int = 0
    
    var image = ""
    var title = ""
    
    var articleType = ""
    
    var pubDate = ""
    
    var firstImg = ""
    
    var ups: Int = 0

    var pageSize: Int = 0

    var total: Int = 0

    var pageNo: Int = 0

    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}


