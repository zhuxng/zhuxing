//
//  CarRootViewController.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/8/13.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

class CarRootViewController: UIViewController, CarListShowDelegate {
    
    var CarListVC = CarListViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

       let CarVC = CarViewController()
        CarVC.carDelegate = self
        CarListVC.view.frame = CGRectMake(screenWidth, 0, screenWidth, screenHeigth)
//        CarVC.title = "汽车"

        
        self.addChildViewController(CarListVC)
        self.addChildViewController(CarVC)
        self.view.addSubview(CarVC.view)
        self.view.addSubview(CarListVC.view)
        
        let Swipe = UISwipeGestureRecognizer()
        Swipe.addTarget(self, action: #selector(CarRootViewController.showCarlist(_:)))
        self.view.addGestureRecognizer(Swipe)
    
    }
    
    //左滑影藏CarlistVC。
    func showCarlist(sender: UISwipeGestureRecognizer){
        if sender.direction == UISwipeGestureRecognizerDirection.Right {
            UIView.animateWithDuration(0.3, animations: { 
                self.CarListVC.view.frame = CGRectMake(screenWidth, 0, screenWidth, screenHeigth)
            })
        }
    }
    
    func CarListVCMove(sender: String, id: String) {
        if sender == "table" {
            UIView.animateWithDuration(0.3, animations: { 
                self.CarListVC.view.frame = CGRectMake(80, 0, screenWidth - 80, screenHeigth)
                self.CarListVC.id = id
                self.CarListVC.refresh()
            })
        }
        
        if sender == "gundong" {
            UIView.animateWithDuration(0.3, animations: { 
                self.CarListVC.view.frame = CGRectMake(screenWidth, 0, screenWidth - 80, screenHeigth)
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
