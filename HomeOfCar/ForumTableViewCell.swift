//
//  ForumTableViewCell.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/8/19.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

class ForumTableViewCell: UITableViewCell {

    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var pubDate: UILabel!
    
    var model: ForumModel!{
        didSet{
            myImageView.sd_setImageWithURL(NSURL(string: model.image), placeholderImage: UIImage(named: "1"))
            
            title.text = model.title
            title.textColor = UIColor.mainColor()
            pubDate.text = model.pubDate
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
