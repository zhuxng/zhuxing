//
//  CarListDetailViewController.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/8/17.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit
import Alamofire


class CarListDetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var model = CarModel()
    
    var tableView = UITableView()
    var headerView = UIView()
    var photoView = UIView()
    var dataArrayTaype = [CarDetailListModel]()
    var dataArrayImage = [ImageModel]()
    var collectionView: UICollectionView?
    
    var headerModel = CarDetailHeaderModel()
    var lineView = UIView()
    var line = UIView()
    var buttonArray = [UIButton]()
    var photoBtnArray = [UIButton]()
    var index = 0
    var imageTaype = 0
    var line2 = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = model.SeriesName!
        getData()
        createUI()
        
        
    }
    //MARK:  createUI
    func createUI(){
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        //分割线的颜色
        tableView.separatorColor = UIColor.mainColor()
        headerView = UIView(frame: CGRectMake(0, 0 ,screenWidth, 200))
        
        
        headerView.backgroundColor = UIColor.greenColor()
    
        let imagView = UIImageView(frame: CGRectMake(10,10,120,100))
        imagView.sd_setImageWithURL(NSURL(string: headerModel.imgURL))
        
        let typeLable = UILabel(frame: CGRectMake(140,10,150,40))
        typeLable.text = "车型:\(headerModel.VType)"
        typeLable.font = UIFont.systemFontOfSize(18)
        
        let priceLabel = UILabel(frame: CGRectMake(140,80,200,30))
        priceLabel.text = "厂商指导价:\(headerModel.dealerQuote)"
        priceLabel.textColor = UIColor.redColor()
        priceLabel.font = UIFont.systemFontOfSize(13)
        
        let pingfenLabel = UILabel(frame: CGRectMake(screenWidth - 60,10,60,40))
        pingfenLabel.text = headerModel.Grade
        pingfenLabel.textColor = UIColor.RGBA(250, 202, 13)
        
        
        headerView.backgroundColor = UIColor.whiteColor()
        headerView.addSubview(imagView)
        headerView.addSubview(typeLable)
        headerView.addSubview(priceLabel)
        headerView.addSubview(pingfenLabel)
        headerView.addSubview(lineView)
        headerView.addSubview(line)
        
        tableView.tableHeaderView = headerView
        
        lineView.frame = CGRectMake(0, 143, screenWidth, 2)
        lineView.backgroundColor = UIColor.darkGrayColor()
        line.frame = CGRectMake(30, 197, screenWidth / 2 - 30, 3)
        line.backgroundColor = UIColor.redColor()

        
        let titleArray = ["车型","图片"]
        for i in 0..<titleArray.count {
            let button = UIButton(frame: CGRectMake(CGFloat(i) * screenWidth / 2, 150, screenWidth / 2, 50))
            button.setTitle(titleArray[i], forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.setTitleColor(UIColor.redColor(), forState: .Selected)
            button.tag = 200 + i
            buttonArray.append(button)
            
            button.addTarget(self, action: #selector(CarListDetailViewController.changeButton(_:)), forControlEvents: .TouchUpInside)
            headerView.addSubview(button)
            
        }
        self.view.addSubview(tableView)
        //注册单元格
        tableView.registerNib(UINib(nibName: "CarListDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
    }
    
    
    //MARK:  createFootUI
    func createFootUI() {
        photoView = UIView(frame: CGRectMake(0,0, screenWidth, screenHeigth - 200))
        photoView.backgroundColor = UIColor.whiteColor()
        tableView.tableFooterView = photoView
        tableView.reloadData()
        let nameArray = ["外观","内饰","空间"]
        for i in 0..<nameArray.count {
            let button = UIButton(frame: CGRectMake(CGFloat(i) * screenWidth / 3, 5, screenWidth / 3, 30))
            button.setTitle(nameArray[i], forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.setBackgroundImage(UIImage(named: "buttonbar_edit"), forState: .Normal)
            button.setTitleColor(UIColor.redColor(), forState: .Selected)
            button.tag = 100 + i
            photoBtnArray.append(button)
            photoView.addSubview(button)
            button.addTarget(self, action: #selector(CarListDetailViewController.footButtonClicked(_:)), forControlEvents: .TouchUpInside)
            if i == 0 {
                button.selected = true
            }
        }
         line2 = UIView(frame: CGRectMake(0,35, screenWidth  / 3, 4))
        line2.backgroundColor = UIColor.mainColor()
        photoView.addSubview(line2)
        
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Vertical
        
        collectionView = UICollectionView(frame: CGRectMake(10, 40, screenWidth - 40, screenHeigth - 240), collectionViewLayout: flowLayout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        photoView.addSubview(collectionView!)
        collectionView?.registerNib(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        collectionView?.backgroundColor = UIColor.whiteColor()
        
    }
    
    
    //MARK:  实现图片按钮装换
    func footButtonClicked(button: UIButton) {
        
        imageTaype = button.tag - 100
         getPhotoData()
        
        for btn in photoBtnArray {
            btn.selected = false
        }
        button.selected = true
        collectionView?.scrollsToTop = true
        collectionView?.scrollRectToVisible(CGRectMake(0, 0, 0, 0), animated: true)
        UIView.animateWithDuration(0.3) {
            self.line2.frame = CGRectMake(CGFloat(self.imageTaype) * screenWidth / 3, 35, screenWidth / 3, 4)
        }
    }
    
    //MARK:  车型、  图片按钮装换
    
    func changeButton(button: UIButton){
        for btn in buttonArray {
            btn.selected = false
        }
        button.selected = true
        index = button.tag - 200
        UIView.animateWithDuration(0.3) { 
            self.line.frame = CGRectMake( 30 + CGFloat(self.index) * screenWidth / 2, 197, screenWidth / 2 - 60, 3)
        }
        if index == 0 {
            photoView.frame = CGRectMake(0, 0, 0, 0)
            tableView.tableFooterView = photoView
            photoView.removeFromSuperview()
            
        }else {
            createFootUI()
        }
       tableView.reloadData()
    }
    
    /**
     头部数据请求
     */
    func getData(){
        Alamofire.request(.GET, "http://app.webcars.com.cn/default.aspx?MsgID=GetSeriesDetailInfo&seriesId=\(model.SeriesId!)&cityName=Province_00").responseJSON { (resp) in
            if let dict = resp.result.value {
                let array = dict.valueForKey("ListContents") as! NSArray
                for sub in array {
                    self.headerModel.setValuesForKeysWithDictionary(sub as! [String : AnyObject])
                }
                self.createUI()
                self.tableView.reloadData()
            }else{
                alert(self)
            }
        }
        
        Alamofire.request(.GET, "http://app.webcars.com.cn/default.aspx?MsgID=GetCarList&seriesId=\(model.SeriesId!)&cityName=Province_00").responseJSON { (resp) -> Void in
            
            if let dict = resp.result.value{
                let array = dict.valueForKey("ListContents") as! NSArray
                for dic in array {
                    let model = CarDetailListModel()
                    model.setValuesForKeysWithDictionary(dic as! [String:AnyObject])
                    self.dataArrayTaype.append(model)
                }
            }
            self.tableView.reloadData()
           
        }
        
    }
    
    
    func getPhotoData(){
        dataArrayImage.removeAll()
        let ulrArray = ["http://tuanadmin.webcars.com.cn/Default.aspx?MsgID=getphotolist&seriesId=\(model.SeriesId!)&phototype=2&ispage=true&pagesize=30&pagenumber=1","http://tuanadmin.webcars.com.cn/Default.aspx?MsgID=getphotolist&seriesId=\(model.SeriesId!)&phototype=4&ispage=true&pagesize=30&pagenumber=1","http://tuanadmin.webcars.com.cn/Default.aspx?MsgID=getphotolist&seriesId=\(model.SeriesId!)&phototype=8&ispage=true&pagesize=30&pagenumber=1"]
        
        Alamofire.request(.GET, ulrArray[imageTaype]).responseJSON { (resp) -> Void in
            
            
            if let array = resp.result.value?.valueForKey("ListContents") as? NSArray {
                for dic in array {
                    let model = ImageModel()
                    model.setValuesForKeysWithDictionary(dic as! [String:AnyObject])
                    self.dataArrayImage.append(model)
                }
                
            }else {
                alert(self)
            }
            self.collectionView?.reloadData()
        }

    
    }
    
    
    
    //MARK: 实现tableView的代理方法。
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return index == 0 ? dataArrayTaype.count : 0
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CarListDetailTableViewCell
        if dataArrayTaype.count > 0 {
            let model = dataArrayTaype[indexPath.row]
            cell.model = model
           
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 100
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
           let carDetailVC = CarDetailViewController()
            carDetailVC.forModel = dataArrayTaype[indexPath.row]
            carDetailVC.TypeModel = model
            carDetailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(carDetailVC, animated: true)

    }
    
    
    
    
    
    
    //MARK: 实现collectionView的代理方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArrayTaype.count
    }
    //确定每个Cell大小
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake((screenWidth) / 4 + 10, 130)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let bigImgVC = BigImageViewController()
        bigImgVC.model = self.dataArrayImage[indexPath.row]
        bigImgVC.dataArray = self.dataArrayImage
        bigImgVC.index = indexPath.row
        bigImgVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(bigImgVC, animated: true)
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ImageCell
        let str = "http://files.webcars.com.cn"
        if dataArrayImage.count > 0 {
            let model = dataArrayImage[indexPath.row]
    //        let data = NSData(contentsOfURL: NSURL(string: model.PhotoUrl)!)
    //        cell.myImageView.image = UIImage(data: data!)
    //        cell.myImageView.setImageWithURL(NSURL(string: model.PhotoUrl)!)
            cell.myImageView.sd_setImageWithURL(NSURL(string: str + model.PhotoUrl))
        }
        return cell
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
