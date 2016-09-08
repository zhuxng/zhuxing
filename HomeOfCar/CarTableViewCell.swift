//
//  CarTableViewCell.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/7/30.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var myImageView: UIImageView!
    
    
    @IBOutlet weak var nameOfCarLabel: UILabel!
    
    
    
    
    var model: CarModel! {
        didSet{
            let url = NSURL(string: model.imgURL!)
            myImageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "2"))
            nameOfCarLabel.text = model.MainBrandName
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
