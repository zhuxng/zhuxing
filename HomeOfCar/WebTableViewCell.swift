//
//  WebTableViewCell.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/8/11.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

class WebTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
