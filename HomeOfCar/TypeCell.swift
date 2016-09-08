//
//  TypeCell.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/7/30.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

class TypeCell: UITableViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!

    
    @IBOutlet weak var pailiangLable: UILabel!

    @IBOutlet weak var valueLabel: UILabel!
    
    var model: CarModel! {
        didSet{
            typeLabel.text = model.YearModel
            pailiangLable.text = model.TrimName
            valueLabel.text = model.dealerQuote
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
