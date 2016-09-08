//
//  Factory.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/7/29.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

class Factory: NSObject {
    
    static func createLabelWith(frame: CGRect, text: String, font: UIFont, textAlignment: NSTextAlignment, textColor: UIColor) -> UILabel {
        let lable = UILabel(frame: frame)
        lable.text = text
        lable.font = font
        lable.textAlignment = textAlignment
        lable.textColor = textColor
        return lable
    }
    
    static func createButtonWith(frame: CGRect, type: UIButtonType, title: String, titleColor: UIColor, targate: AnyObject?, imageName: String, action: Selector, backgroundImageName: String) -> UIButton {

        let button = UIButton(type:type)
        button.frame = frame
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(titleColor, forState: .Normal)
        button.setImage(UIImage(named: imageName), forState: .Normal)
        button.setBackgroundImage(UIImage(named: backgroundImageName), forState: .Normal)
        button.addTarget(targate, action: action, forControlEvents: .TouchUpInside)
        return button
    }
    
    static func createImageView(frame: CGRect, imageName: String) -> UIImageView {
        let imageView = UIImageView(frame: frame)
        imageView.image = UIImage(named: imageName)
        return imageView
    }
    
    static func createTextField(frame: CGRect, text: String, placeholder: String) -> UITextField {
        let textField = UITextField(frame: frame)
        textField.text = text
        textField.placeholder = placeholder
        
        return textField
    }

}
