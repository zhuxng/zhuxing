//
//  HomeViewController.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/7/29.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

class HomeViewController: RootViewController,  UICollectionViewDelegateWaterFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    var cyclePlaying: Carousel!
    var collectionView: UICollectionView!
    var flowlayout = UICollectionViewFlowLayout()
    var page = 1
    
    var imageArray = ["1","12","3","4"]
    var titleArray = ["头条","新车","导购","测评"]

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        createNav()
    }
    
    func createUI() {
        //轮播
        cyclePlaying = Carousel(frame: CGRectMake(0, 0, screenWidth, screenHeigth / 3))
        cyclePlaying.needPageControl = true
        cyclePlaying.infiniteLoop = true
        cyclePlaying.pageControlPositionType = PAGE_CONTROL_POSITION_TYPE_MIDDLE
        cyclePlaying.imageArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]
        self.view.addSubview(cyclePlaying)
        
        //创建colletionView
        
        flowlayout.itemSize = CGSizeMake((screenWidth - 10) / 2, 130)
        collectionView = UICollectionView(frame: CGRectMake(0, screenHeigth / 3, screenWidth, (screenHeigth / 3) * 2 ), collectionViewLayout: flowlayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(collectionView)

        
        collectionView.registerNib(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        collectionView.registerClass(FootCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "Foot")
    
    }
    
    func createNav() {
        titleLable?.text = "首页"
        rightBUtton?.setImage(UIImage(named: "iconfont-dingwei"), forState: .Normal)
        addRigthTarget(#selector(HomeViewController.ShowCurrentLocation))
        
    }
    
    //MARK: 点击实现定位功能
    func ShowCurrentLocation() {
        
        
    }

    // MARK: 实现方法
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! HomeCollectionViewCell
        cell.myImageView.image = UIImage(named: imageArray[indexPath.row])
        cell.titleLabel.text = titleArray[indexPath.row]
        return  cell
    }
    
    func collectionView(collectionView: UICollectionView!, waterFlowLayout layout: NBWaterFlowLayout!, heightForItemAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
      
        return 150
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let index = indexPath.item
        if index == 0 {
            let webVC = WebViewController()
            navigationController?.pushViewController(webVC, animated: true)
        }
        
        else if index == 1 {
            let NewCarVC = NewCarViewController()
            
            navigationController?.pushViewController(NewCarVC, animated: true)
        }
        else if index == 2 {
            let DaoGouVC = DaoGouViewController()
            
            navigationController?.pushViewController(DaoGouVC, animated: true)

        }
        else if index == 3 {
            let ChePingVC = ChePingViewController()
            
            navigationController?.pushViewController(ChePingVC, animated: true)

        }
        
        
    }
    
    
    // 为了实现最后一个Item 所做操作
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSizeMake(screenWidth, 100)
        
    }
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView{
        var view: FootCollectionReusableView?
    
        if (kind == UICollectionElementKindSectionFooter) {
            view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Foot", forIndexPath: indexPath) as? FootCollectionReusableView
            view!.button.setTitle("用车", forState: .Normal)
            view?.button.titleLabel?.font = UIFont.systemFontOfSize(32)
            view?.button.setBackgroundImage(UIImage(named: "14"), forState: .Normal)
//            view!.button.setImage(UIImage(named: "14"), forState: .Normal)
            view?.button.addTarget(self, action: #selector(HomeViewController.xuanzhe), forControlEvents: .TouchUpInside)
        }
        
        return view!
    }
    

    func xuanzhe() {
        let YongcheVC = YongCheViewController()
        
        navigationController?.pushViewController(YongcheVC, animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
