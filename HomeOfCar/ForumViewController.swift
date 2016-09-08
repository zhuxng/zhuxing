//
//  ForumViewController.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/7/29.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
class ForumViewController: RootViewController , UITableViewDelegate, UITableViewDataSource{

    var tableView = UITableView()
    
    var dataArray = [ForumModel]()
    
    var headerView = UIView()
    
    var page = 1
    
    
    let imageArray = ["qc1","qc2","qc3","qc4","qc5","qc6"]
    let titleArray = ["文化","行业","赛事","用车","游记","技术"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLable?.text = "论坛"
        createUI()
        refreshUI()
    }

    
    func createUI() {
        tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeigth), style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(UINib(nibName: "ForumTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        self.view.addSubview(tableView)
        
        headerView = UIView(frame: CGRectMake(0, 0, screenWidth, 200))
        headerView.backgroundColor = UIColor.lightGrayColor()
        headerView.layer.borderColor = UIColor.mainColor().CGColor
        headerView.layer.borderWidth = 5
        
        let buttonLocation = (screenWidth - 60) / 3
        
        for i in 0..<6 {
            let row = CGFloat(i / 3)
            let col = CGFloat(i % 3)
            let button = UIButton(frame: CGRectMake(60 + col * buttonLocation , 10 + row * 90, 60, 60))
            button.tag = 10 + i
            let label = UILabel(frame: CGRectMake(70 + col * buttonLocation , 80 + row * 80, 60, 20))
            label.text = titleArray[i]
            button.setBackgroundImage(UIImage(named: imageArray[i]), forState: .Normal)
            headerView.addSubview(button)
            headerView.addSubview(label)
            
            let tap = UITapGestureRecognizer()
            tap.addTarget(self, action: #selector(ForumViewController.buttonClicked(_:)))
            button.addGestureRecognizer(tap)
        }
        
        tableView.tableHeaderView = headerView
        
        
        
    }
    func refreshUI() {
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
            self.page = 1
            self.dataArray.removeAll()
            self.getData()
        })
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            self.page += 1
            self.getData()
        })
        tableView.mj_header.beginRefreshing()
        
    }
    
    
    func getData(){
    Alamofire.request(.GET, "http://mrobot.pcauto.com.cn/v2/cms/channels/5?pageNo=\(self.page)&pageSize=20&v=4.0.0").responseJSON { (resp) in
        if let dict = resp.result.value {
            let array = dict.valueForKey("data") as! NSArray
            for sub in array {
                let model = ForumModel()
                model.setValuesForKeysWithDictionary(sub as! [String : AnyObject])
                self.dataArray.append(model)
                }
        }
            if self.page == 1 {
                self.tableView.mj_header.endRefreshing()
            }
            else {
                self.tableView.mj_footer.endRefreshing()
            }
        self.tableView.reloadData()
        
        }
        
    }
    
    
    
    func buttonClicked(sender: UITapGestureRecognizer) {
        let yuanFrame = sender.view!.frame
        let tag = (sender.view?.tag)! - 10
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            sender.view?.bounds = CGRectMake(0,0,100,100)
            sender.view?.alpha = 0
        }) { (resp) -> Void in
            sender.view!.frame = yuanFrame
            sender.view?.alpha = 1
            let tfVC = TuristForumViewController()
            tfVC.mytitle = self.titleArray[tag]
            tfVC.index = tag
            tfVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(tfVC, animated: false)
        }

        
    }
    
    
    //实现tableView的代理方法
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ForumTableViewCell
        cell.model = dataArray[indexPath.row]
        
        
        
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
