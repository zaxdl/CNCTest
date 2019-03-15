//
//  ChartList.swift
//  CNCTest
//
//  Created by 王国宇 on 2019/3/13.
//  Copyright © 2019 王国宇. All rights reserved.
//

import Foundation
import UIKit
class UserInfoData: NSObject,NSCoding {
    var name:String
    var data:String
    var time:String
    
    required init(name:String="",data:String="",time:String="") {
        self.name = name
        self.data = data
        self.time = time
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(data, forKey: "Data")
        aCoder.encode(time, forKey: "Time")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "Name") as? String ?? ""
        self.data = aDecoder.decodeObject(forKey: "Data") as? String ?? ""
        self.time = aDecoder.decodeObject(forKey: "Time") as? String ?? ""
    }
    
}
