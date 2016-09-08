//
//  CarListDetailTableViewCell.swift
//  
//
//  Created by 朱星 on 16/8/18.
//
//

import UIKit

class CarListDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var YearModel: UILabel!
    
    @IBOutlet weak var TrimName: UILabel!
    
    @IBOutlet weak var TrimCategory: UILabel!
    
    @IBOutlet weak var dealerQuote: UILabel!
    
    
    var model: CarDetailListModel! {
        didSet {
            
            YearModel.text = model.YearModel
            TrimName.text = model.TrimName
            TrimCategory.text = model.TrimCategory
            dealerQuote.text = "厂商指导价：\(model.dealerQuote)"
            dealerQuote.textColor = UIColor.redColor()
            
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
