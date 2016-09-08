//
//  CarDetailViewController.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/8/13.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit
import Alamofire
class CarDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateWaterFlowLayout {
    var forModel: CarDetailListModel!
    var TypeModel: CarModel!
    var myImageView = UIImageView()
    var tableView = UITableView()
    var collectionView: UICollectionView?
    var model1 = CarDetailModel()
    var model2 = CarDetailModel2()
    let titleArray = ["车身结构","环保标准","发动机结构","车体长宽高","制造商","汽车类型"]
    let keyArray = ["CartType","EPS","Engine","LWH","Make","VType"]
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
    createUI()
    getData()
        
    }
    
    func getData() {
    
        Alamofire.request(.GET, "http://tuanadmin.webcars.com.cn/Default.aspx?MsgID=getphotolist&seriesId=\(TypeModel.SeriesId!)&phototype=2&ispage=true&pagesize=30&pagenumber=1").responseJSON { (resp) -> Void in
        if let array = resp.result.value?.valueForKey("ListContents") as? NSArray {
            if array.count > 0 {
                if  let imgStr = array[2].valueForKey("PhotoUrl") as? String {
                    self.myImageView.sd_setImageWithURL(NSURL(string:"http://files.webcars.com.cn" + imgStr), placeholderImage:UIImage(named: "iconfont-pengyouquan"))
                    }
                } else {
                self.myImageView.image = UIImage(named: "iconfont-pengyouquan")
            }
            
        }else{
            alert(self)
            }
    }
    
    Alamofire.request(.GET, "http://app.webcars.com.cn:8080/default.aspx?MsgID=GetParameter&CarId=\(forModel.CarId)").responseJSON { (resp) -> Void in
        if  let dic1 = resp.result.value?.valueForKey("CarsContents") {
                if  let dic2 = resp.result.value?.valueForKey("CarsParContents") {
                    self.model1.setValuesForKeysWithDictionary(dic1 as! [String:AnyObject])
                    self.model2.setValuesForKeysWithDictionary(dic2 as! [String:AnyObject])
                    self.tableView.reloadData()
                    self.collectionView?.reloadData()
                    }
            }else{
                alert(self)
            }
        }
    }
    
    
    func createUI() {
    
        tableView = UITableView(frame: self.view.bounds,style:.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        //estimatedRowHeight: 预估行高
        tableView.estimatedRowHeight = 400.0
        //行高自适应
        tableView.rowHeight = UITableViewAutomaticDimension
        //定制瀑布流
        let flout = NBWaterFlowLayout()
        flout.itemSize = CGSizeMake((screenWidth ) / 2, 70)
        //Columns： 列
        flout.numberOfColumns = 2
        //item 相对边距
        flout.sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flout.delegate = self
        //设置collectionview
        collectionView = UICollectionView(frame: CGRectMake(0,0,screenWidth ,screenHeigth),collectionViewLayout:flout)
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.registerNib(UINib(nibName: "CarDetailCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        myImageView = UIImageView(frame: CGRectMake(0, -200,screenWidth,200))
        
        
        tableView.addSubview(myImageView)
        tableView.contentOffset = CGPointMake(0,-200)
        tableView.contentInset = UIEdgeInsetsMake(200,0,0,0)
        tableView.showsVerticalScrollIndicator = false
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self.tableView {
            // 获取scrollView的偏移量
            // 纵向偏移量
            let yOffset = scrollView.contentOffset.y
            // 横向偏移量随着纵向偏移量的变化而变化
            let xOffset = (200 + yOffset) / 2
            if yOffset < -200 {
            var rect = myImageView.frame
            // 纵坐标
            rect.origin.y = yOffset
            // 高度
            rect.size.height = -yOffset
            // 横坐标
            rect.origin.x = xOffset
            // 宽度
            rect.size.width = screenWidth + fabs(xOffset) * 2
            myImageView.frame = rect
            
            }
        }
    }
    
    
    func collectionView(collectionView: UICollectionView!, waterFlowLayout layout: NBWaterFlowLayout!, heightForItemAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 140
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return titleArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CarDetailCollectionCell
        
        cell.titleLabel.text = titleArray[indexPath.row]
        cell.contentLabel.text = model2.valueForKey(keyArray[indexPath.row]) as? String
        
        cell.mainView.layer.borderColor = UIColor.redColor().CGColor
        cell.mainView.layer.borderWidth = 1
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let ve = UIView(frame: CGRectMake(0,0,screenWidth,0))
        let nameLabel = UILabel(frame: CGRectMake(30,5,90,30))
        nameLabel.text = model1.SeriesName
        nameLabel.font = UIFont.systemFontOfSize(20)
        
        let priceLabel = UILabel(frame: CGRectMake(30,40,200,30))
        priceLabel.text = "厂商指导价:\(model1.MSRP)"
        priceLabel.font = UIFont.systemFontOfSize(14)
        priceLabel.textColor = UIColor.redColor()
        
        let yearLabel = UILabel(frame: CGRectMake(110,5,250,30))
        yearLabel.text = model1.YearModel + " " + model1.TrimName + " " + model1.TrimCategory
        yearLabel.minimumScaleFactor = 0.5
        yearLabel.adjustsFontSizeToFitWidth = true
        
        ve.addSubview(yearLabel)
        ve.addSubview(priceLabel)
        ve.addSubview(nameLabel)
        
        ve.backgroundColor = UIColor.whiteColor()
        
        return ve
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        if cell == nil {
        cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        }
        
        cell?.addSubview(collectionView!)
        
        return cell!
    }
    
}
