//
//  DataModle.swift
//  HomeOfCar
//
//  Created by 朱星 on 16/8/13.
//  Copyright © 2016年 zhuxing. All rights reserved.
//

import UIKit

class DataHome: NSObject {

//    
//    // 单例对象（类方法／类对象）,在外面调用的时候使用
//    static let defaultManager = DataHome()
//    // 管理数据库的对象
//    let fmdb: FMDatabase
//    // 线程锁
//    var lock = NSLock()
//    
//    
//    //1.重写初始化方法，创建数据库
//    override init() {
//        // 设置数据库的路径
//        let path = NSHomeDirectory().stringByAppendingFormat("/Documents/student.db")
//        // 创建管理数据库的对象
//        fmdb = FMDatabase(path: path)
//        // 判断数据库管理对像是否创建成功
//        if !fmdb.open() {
//            print("数据库打开失败")
//            return
//        }
//        // 创建数据库的sql 语句
//        let creatSql = "create table if not exists carTypeModel(SeriesId varchar(1024),SeriesName varchar(1024),dealerQuote varchar(1024),imgURL varchar(1024))"
//        // 进行创建并且做错误处理
//        do {
//            try fmdb.executeUpdate(creatSql, values: nil)
//            
//        } catch {
//            print(fmdb.lastErrorMessage())
//        }
//    }
//    
//    
//    //2.增加数据
//    func insertWithModel(model:carTypeModel) {
//        // 使用线程锁进行加锁操作，完成操作之后进行解锁，主要是为了防止在操作数据的过程中线程安全
//        lock.lock()
//        // 插入数据的sql语句
//        let insertSql = "insert into carTypeModel(SeriesId, SeriesName,dealerQuote,imgURL) values(?,?,?,?)"
//        // 更新数据库
//        do {
//            try fmdb.executeUpdate(insertSql, values: [model.SeriesId,model.SeriesName,model.dealerQuote,model.imgURL])
//        } catch {
//            print(fmdb.lastErrorMessage())
//        }
//        
//        // 解锁
//        lock.unlock()
//    }
//    
//    
//    // 3.删除数据
//    func deleteWith(model: carTypeModel) {
//        lock.lock()
//        // 删除数据的sql语句
//        let deletSql = "delete from carTypeModel where SeriesId = ?"
//        do {
//            try fmdb.executeUpdate(deletSql, values: [model.SeriesId])
//        } catch {
//            print(fmdb.lastErrorMessage())
//        }
//        lock.unlock()
//    }
//    
//    
//    
//    
//    //5. 查询数据
//    func fetchAll () -> [carTypeModel] {
//        lock.lock()
//        // 定义数组
//        var tempArray = [carTypeModel]()
//        // 查询数据库的sql语句
//        let fetchSql = "select * from carTypeModel"
//        // 进行查询
//        do {
//            let set = try fmdb.executeQuery(fetchSql, values: nil)
//            // 进行遍历查询结果，并且将查询结果放到数组中
//            while set.next() {
//                let model = carTypeModel()
//                
//                // 对字段进行赋值
//                model.SeriesId = set.stringForColumn("SeriesId")
//                model.SeriesName = set.stringForColumn("SeriesName")
//                model.dealerQuote = set.stringForColumn("dealerQuote")
//                model.imgURL = set.stringForColumn("imgURL")
//                
//                tempArray.append(model)
//            }
//        } catch {
//            print(fmdb.lastErrorMessage())
//        }
//        lock.unlock()
//        return tempArray
//    }
}
