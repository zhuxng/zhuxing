//
//  HomeViewController.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/7/29.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit
import MJRefresh
import Alamofire

class CarViewController: RootViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    var tableView =  UITableView()

    var hub = MBProgressHUD()
    
    var dataArray: [[CarModel]] = [[]]
    var sectionArray = [String]()
    
    var page = 0
    
    weak var carDelegate: CarListShowDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //函数顺序也很重要。
        createUI()
        getData()
        titleLable?.text = "汽车"

    }
    
    func createUI() {
        tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeigth), style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadSectionIndexTitles()
        self.view.addSubview(tableView)
        
        hub = MBProgressHUD(view: self.view)
        hub.labelText = "玩命加载......"
        hub.tintColor = UIColor.redColor()
        hub.color = UIColor.mainColor()
        self.view.addSubview(hub)
        
        tableView.registerNib(UINib(nibName: "CarTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    func getData(){
        hub.show(true)
        Alamofire.request(.GET, "http://app.webcars.com.cn/default.aspx?MsgID=getAllBrandList").responseJSON { (resp) in
           
            if let dict = resp.result.value {
                let array = dict.valueForKey("ListContents") as! NSArray
                
                
                for i in 0..<array.count {
                    let subDict = array[i]
                    self.dataArray.append([CarModel]())
                    let str = subDict.valueForKey("PinYin") as! String
                    self.sectionArray.append(str)
                    let subArray = subDict.valueForKey("GroupInfo") as! NSArray
                    for sub in subArray {
                        let model = CarModel()
                        model.setValuesForKeysWithDictionary(sub as! [String: AnyObject])
                        self.dataArray[i].append(model)
                    }
                }
            }else{
                let alert = UIAlertController(title: "温馨提示", message: "目前网络处于异常，请检查网络稍后再试。", preferredStyle: .Alert)
                let okbtn = UIAlertAction(title: "确定", style: .Default) { (action) -> Void in
                    self.navigationController?.popViewControllerAnimated(true)
                }
                alert.addAction(okbtn)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            self.hub.hide(true)
            self.tableView.reloadData()
        }
        
    }

    
    // MARK: 实现方法
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return sectionArray
    }
    // 右边标题栏和分组头对应
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return index
    }
    //返回分区的个数（分组）
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionArray.count
    }
    //组头设置
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView(frame: CGRectMake(0, 0, screenWidth, 30))
        sectionView.backgroundColor = UIColor.RGBA(237, 237, 237)
        let label = UILabel(frame: CGRectMake(0, 0, 30, 30))
        label.text = sectionArray[section]
        label.textAlignment = .Center
        label.textColor = UIColor.RGBA(86, 190, 241)
        sectionView.addSubview(label)
        
        return sectionView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CarTableViewCell
        cell.model = dataArray[indexPath.section][indexPath.row]
        
        return cell
    }
   
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
        
    }
    //利用协议传值
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        carDelegate?.CarListVCMove("table", id: dataArray[indexPath.section][indexPath.row].BrandID!)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        carDelegate?.CarListVCMove("gundong", id: "")
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
