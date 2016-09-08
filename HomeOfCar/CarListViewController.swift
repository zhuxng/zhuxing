//
//  CarListViewController.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/8/13.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh



protocol CarListShowDelegate: class {
    func CarListVCMove(sender: String, id: String)
}



class CarListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var id = ""
    var tableVew = UITableView()
    var dataArrary = [[CarModel]]()
    var sectionArray = [String]()
    var page = 1
    var hub = MBProgressHUD()

    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
    }
    
    func createUI(){
        tableVew = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeigth - 70))
        tableVew.delegate = self
        tableVew.dataSource = self
//        tableVew.reloadSectionIndexTitles()
        tableVew.registerNib(UINib(nibName: "CarDetailTableViewCell",bundle: nil), forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableVew)
        //展示垂直滚动器  并且设置在了左边，默认是在右边
        tableVew.showsVerticalScrollIndicator = true
        
        tableVew.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, tableVew.bounds.size.width - 7)
        hub = MBProgressHUD(view: self.view)
        hub.labelText = "请皇上稍等，卑职正在努力加载......"
        hub.progress = 0.5
        hub.color = UIColor.whiteColor()
        //        hub.center = self.view.center
        hub.tintColor = UIColor.blackColor()
        hub.backgroundColor = UIColor.whiteColor()
        hub.activityIndicatorColor = UIColor.redColor()
        self.view.addSubview(hub)
        
      
    }
    
    func refresh(){
        tableVew.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
            self.page = 1
            self.getData()
        })
        tableVew.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            self.page += 1
            self.getData()
        })
    
        tableVew.mj_header.beginRefreshing()
    }
    
    func getData() {
        
        self.sectionArray.removeAll()
        self.dataArrary.removeAll()
        hub.show(true)
        Alamofire.request(.GET, "http://app.webcars.com.cn/default.aspx?MsgID=getAllSeriesListbyCityName&brandid=\(id)&cityName=Province_00").responseJSON { (resp) in
            
            
            if let dict = resp.result.value {
             
                let array = dict.valueForKey("ListContents") as! NSArray
                for i in 0..<array.count {
                    let dic = array[i]
                    let str = dic.valueForKey("ManuName") as! String
                    self.sectionArray.append(str)
                    self.dataArrary.append([CarModel]())
                    let array2 = dic.valueForKey("GroupInfo") as! NSArray
                    for subdict in array2{
                        let model = CarModel()
                        model.setValuesForKeysWithDictionary(subdict as! [String : AnyObject])
                        self.dataArrary[i].append(model)
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
            if self.page == 1 {
                self.tableVew.mj_header.endRefreshing()
            }else{
                self.tableVew.mj_footer.endRefreshing()
                
            }
            self.hub.hide(true)
            self.tableVew.reloadData()
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataArrary.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView(frame: CGRectMake(0, 0, screenWidth, 30))
        sectionView.backgroundColor = UIColor.RGBA(237, 237, 237)
        let label = UILabel(frame: CGRectMake(20, 0, 200, 30))
        label.text = sectionArray[section]
        label.textAlignment = .Center
        label.textColor = UIColor.RGBA(86, 190, 241)
        sectionView.addSubview(label)
        
        return sectionView
    }
    
    
    
    
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArrary[section].count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableVew.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CarDetailTableViewCell
        if dataArrary.count > 0 {
          
        cell.model = dataArrary[indexPath.section][indexPath.row]
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let carListDetailVC = CarListDetailViewController()
        carListDetailVC.model = dataArrary[indexPath.section][indexPath.row]
        
        navigationController?.pushViewController(carListDetailVC, animated: true)
        
        
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
