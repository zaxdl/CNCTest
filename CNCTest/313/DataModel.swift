//
//  DataModel.swift
//  CNCTest
//
//  Created by 王国宇 on 2019/3/13.
//  Copyright © 2019 王国宇. All rights reserved.
//

import Foundation
import UIKit
class DataModel: NSObject {
    var userList = [UserInfoData]()
    
    override init() {
        super.init()
//        print("沙盒文件夹路径：\(documentsDirectory())")
//        print("数据文件路径：\(dataFilePath())")
    }
    
    func saveData() {
        let data = NSMutableData()
        //申明归档对象
        let archiver = NSKeyedArchiver(forWritingWith: data)
        //将lists以对应Checklist关键词编码
        archiver.encode(userList, forKey: "userList")
        archiver.finishEncoding()
        data.write(toFile: datafilePath(), atomically: true)
    }
    
    //读取数据
    func loadData() {
        //文件数据地址
        let path = self.datafilePath()
        //声明文件管理器
        let defaultManager = FileManager()
        //通过文件地址判断是否存在
        if defaultManager.fileExists(atPath: path) {
            let url = URL(fileURLWithPath: path)
            let data = try! Data(contentsOf: url)
            //解码器
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            //通过d归档设置关键字Checklist还原lists
            userList = unarchiver.decodeObject(forKey: "userList") as! Array
            unarchiver.finishDecoding()
        }
        
    }
    
    //获取沙盘文件夹路径
    func documentsDirectory()->String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = path.first!
        return documentsDirectory
    }
    //获取数据文件地址
    func datafilePath()->String {
        return self.documentsDirectory().appendingFormat("/userList.plist")
    }
}
