//
//  WebViewController.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/8/11.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh


class WebViewController: RootViewController, UITableViewDelegate, UITableViewDataSource {
    var toutiaoArray = [homeCarModel]()
    var tableView = UITableView()
    var page = 1
     var hub = MBProgressHUD()
    var urlstr = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
        createNav()
        refresh()

        
    }
    
    func refresh() {
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            self.page = 1
            self.toutiaoArray.removeAll()
            self.getData()

        })
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { () -> Void in
            self.page += 1
            self.getData()
        })
       tableView.mj_header.beginRefreshing()
    }

    
    func getData(){
        hub.show(true)
        Alamofire.request(.GET, "http://mrobot.pcauto.com.cn/v2/cms/channels/1?pageNo=\(page)&pageSize=20&serialIds=2143,3404&v=4.0.0").responseJSON { (resp) in
            
            if let dict = resp.result.value {
                let DATAArray = dict.valueForKey("data") as! NSArray
                for sub in DATAArray {
                    let model = homeCarModel()
                    model.setValuesForKeysWithDictionary(sub as! [String : AnyObject])
                    if sub.valueForKey("channelId") as! Int == 1 {
                        self.toutiaoArray.append(model)
                        
                    }
                }
            }else{
                let alert = UIAlertController(title: "温馨提示", message: "皇上目前网络异常，请检查网络稍后再试。", preferredStyle: .Alert)
                let okbtn = UIAlertAction(title: "确定", style: .Default) { (action) -> Void in
                    self.navigationController?.popViewControllerAnimated(true)
                }
                alert.addAction(okbtn)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            if self.page == 1 {
                self.tableView.mj_header.endRefreshing()
            }else{
                self.tableView.mj_footer.endRefreshing()
            }
            self.hub.hidden = true
            self.tableView.reloadData()
        }
    }

    
    func createUI() {
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorColor = UIColor.RGBA(186, 219, 241)
        tableView.registerNib(UINib(nibName: "WebTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        //啥意思？
        hub = MBProgressHUD(view: self.view)
        hub.labelText = "请皇上稍等，卑职正在努力加载......"
        hub.progress = 0.5
        hub.color = UIColor.whiteColor()
//        hub.center = self.view.center
        hub.tintColor = UIColor.blackColor()
        hub.backgroundColor = UIColor.whiteColor()
        hub.activityIndicatorColor = UIColor.redColor()
        self.view.addSubview(hub)
        
        self.view.addSubview(tableView)
        self.view.addSubview(hub)
        

    
    }
    
    func createNav() {
        titleLable?.text = "头条"

        self.leftButton?.setImage(UIImage(named: "返回2"), forState: .Normal)
        
        addLeftTarget(#selector(WebViewController.backButtonClicked))
  
    }
    
    func backButtonClicked(){
        navigationController?.popViewControllerAnimated(true)
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toutiaoArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! WebTableViewCell
        if toutiaoArray.count > 0 {
            let model = toutiaoArray[indexPath.row]
            let url = NSURL(string: model.image!)
            cell.myImageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "占位图"))
            cell.titleLabel.lineBreakMode = .ByTruncatingMiddle
            cell.titleLabel.numberOfLines = 0
            cell.titleLabel.text = model.title
            cell.timeLabel.text = model.pubDate
            }
       
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let WebDetailVC = WebDetailViewController()
        WebDetailVC.model = toutiaoArray[indexPath.row]
        WebDetailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(WebDetailVC, animated: true)
    
        
        
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
