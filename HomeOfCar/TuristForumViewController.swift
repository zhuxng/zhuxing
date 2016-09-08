//
//  TuristForumViewController.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/8/19.
//  Copyright © 2016年 zhuxing. All rights reserved.
//


import UIKit
import Alamofire
import MJRefresh

class TuristForumViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView = UITableView()
    
    var dataArray = [userCarModel]()
    var mytitle: String!
    var index: Int!
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = mytitle
        creatUI()
        refresh()
    }
    
    func refresh() {
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            self.page = 1
            self.dataArray.removeAll()
            self.getData()
        })
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { () -> Void in
            self.page += 1
            self.getData()
        })
        
        tableView.mj_header.beginRefreshing()
    }
    
    func getData() {
        
        let urlArray = ["http://mrobot.pcauto.com.cn/v2/cms/channels/5?pageNo=\(page)&pageSize=20&v=4.0.0",
                        "http://mrobot.pcauto.com.cn/v2/cms/channels/15?pageNo=\(page)&pageSize=20&v=4.0.0",
                        "http://mrobot.pcauto.com.cn/v2/cms/channels/9?pageNo=\(page)&pageSize=20&v=4.0.0",
                        "http://mrobot.pcauto.com.cn/v2/cms/channels/10?pageNo=\(page)&pageSize=20&v=4.0.0",
                        "http://mrobot.pcauto.com.cn/v2/cms/channels/16?pageNo=\(page)&pageSize=20&v=4.0.0",
                        "http://mrobot.pcauto.com.cn/v2/cms/channels/8?pageNo=\(page)&pageSize=20&v=4.0.0"]
        
        Alamofire.request(.GET, urlArray[index]).responseJSON { (resp) -> Void in
            if let array = resp.result.value?.valueForKey("data") as? NSArray {
                for dic in  array {
                    let model = userCarModel()
                    model.setValuesForKeysWithDictionary(dic as! [String:AnyObject])
                    self.dataArray.append(model)
                }
                if self.page == 1 {
                    self.tableView.mj_header.endRefreshing()
                }
                else {
                    self.tableView.mj_footer.endRefreshing()
                }
                
                self.tableView.reloadData()
                
            }
            else {
                
                alert(self)
            }
        }
        
    }
    
    
    func creatUI() {
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.registerNib(UINib(nibName: "ForumTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ForumTableViewCell
        if dataArray.count > 0 {
            let model = dataArray[indexPath.row]
            cell.myImageView.sd_setImageWithURL(NSURL(string: model.image))
            cell.title.text = model.title
            cell.pubDate.text = model.pubDate
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let webVC = WebForumViewController()
        webVC.urlstr = dataArray[indexPath.row].url
        webVC.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(webVC, animated: true)
    }
    
    
}
