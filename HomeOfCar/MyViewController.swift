//
//  MyViewController.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/7/29.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

class MyViewController: RootViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView = UITableView()
    //头部图片
    var headerImageView = UIImageView()
    //图片的原始高度
    let imageOriginalHeight: CGFloat = 200.0
    
    //图标
    var imageArray = NSArray()
    //标题
    var titleArray = NSArray()
    //夜间模式
    var darkView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLable?.text = "我的"
        //给数组中添加元素
        self.imageArray = ["iconfont-iconfontaixinyizhan","iconfont-lajitong","iconfont-yejianmoshi","iconfont-zhengguiicon40","iconfont-guanyu"]
        self.titleArray = ["我的喜欢","清理缓存","夜间模式","推送消息","关于"]
        
        createUI()
        
    }
    
    func createUI() {
        self.tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeigth), style: UITableViewStyle.Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        //取消多余的线条
        self.tableView.tableFooterView = UIView()
        //设置分割线的颜色
        self.tableView.separatorColor = UIColor.RGBA(255, 156, 187)
        
        //创建imageView
        self.headerImageView = Factory.createImageView(CGRectMake(0, -imageOriginalHeight, screenWidth, imageOriginalHeight), imageName: "12")
        self.tableView.addSubview(self.headerImageView)
        
        //设置tableView的内容从图片的下方开始显示,UIEdgeInsetsMake表示的是距离边界的距离,是一个相对值，参数表示上左下右
        self.tableView.contentInset = UIEdgeInsetsMake(imageOriginalHeight, 0, 0, 0)
        
        
        //注册cell
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        
        //创建夜间模式
        self.darkView = UIView(frame: self.view.bounds)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        //设置尾部控件
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 4 {
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        } else {
            //创建switch按钮
            let swi = UISwitch(frame: CGRectMake(screenWidth - 70,5,60,34))
            //设置内嵌颜色
            //swi.onTintColor = UIColor.redColor()
            //设置边框颜色
            //swi.tintColor = UIColor.greenColor()
            
            swi.tag = indexPath.row
            /***************************/
            cell.addSubview(swi)
            
            //添加响应事件
            swi.addTarget(self, action: #selector(MyViewController.changeValue(_:)), forControlEvents: UIControlEvents.ValueChanged)
            
        }
        
        //赋值
        cell.imageView?.image = UIImage(named: self.imageArray[indexPath.row] as! String)
        cell.textLabel?.text = self.titleArray[indexPath.row] as? String
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    func changeValue(swi:UISwitch) {
        if swi.tag == 2 {
            if swi.on {
                //出现夜间模式
                //关闭darkView的用户交互
                self.darkView.userInteractionEnabled = false
                //设置背景颜色
                self.darkView.backgroundColor = UIColor(white: 0, alpha: 0.2)
                //将darkView添加到window上
                //获取window
                let app = UIApplication.sharedApplication()
                let delegate = app.delegate as! AppDelegate
                delegate.window?.addSubview(self.darkView)
                
            } else {
                self.darkView.removeFromSuperview()
            }
        }
        
    }
    
    //图头放大效果的实现，使用scrollView的代理方法
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //实现思路：通过tableVIew滑动的时候，获取它的偏移量，通过滑动过程中偏移量的变化来改变头部图片的大小
        if scrollView == self.tableView {
            //获取scrollVIew的偏移量
            //纵向偏移量
            let yOffset = scrollView.contentOffset.y
            //横向偏移量，横向偏移量随着纵向偏移量的变化而变化
            let xOffset = (imageOriginalHeight + yOffset) / 2
            
            if yOffset < -imageOriginalHeight {
                var rect = self.headerImageView.frame
                //纵坐标
                rect.origin.y = yOffset
                //高度
                rect.size.height = -yOffset
                //横坐标
                rect.origin.x = xOffset
                //宽度
                rect.size.width = screenWidth + fabs(xOffset) * 2
                self.headerImageView.frame = rect
            }
        }
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
