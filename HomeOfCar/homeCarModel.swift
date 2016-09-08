//
//  homeCarModel.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/8/11.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import Foundation

class homeCarModel: NSObject {
    var pageNo: Int = 0
    
    var pageSize: Int = 0
    
    var topData: [String]?
    
    var total: Int = 0

    var classfy: String?
    
    var topicUrl: String?
    
    var id: String?
    
    var image: String?
    
    var articleType: String?
    
    var pubDate: String?
    
    var url: String?
    var downs: Int = 0

    var channelId: Int = 0
    
    var count: Int = 0

    var channelName: String?
    
    var imageList: String?
    
    var title: String?
    
    var type: Int = 0
    

    var voteId: String?
    
    var ups: Int = 0
    
    var seq: Int = 0
    
    var updateAt: Int = 0
    
    var ccuri: String?
    
    
    var vcuri: String?
    
    var touri: String?


    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }


}

