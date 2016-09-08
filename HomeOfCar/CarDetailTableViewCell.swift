//
//  CarDetailTableViewCell.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/7/30.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

class CarDetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var SeriesNameLabel: UILabel!
    
    @IBOutlet weak var numLabel: UILabel!
    
    @IBOutlet weak var dealerQuoteLabel: UILabel!
    
    
    
    
    var model: CarModel! {
        didSet{
            let url = NSURL(string: model.imgURL!)
            myImageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "2"))
            SeriesNameLabel.text = model.SeriesName
            numLabel.text = "共有\(model.carcount!)款车型"
            
            dealerQuoteLabel.text = model.dealerQuote
            
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
