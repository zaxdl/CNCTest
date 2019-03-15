//
//  UserInfo.swift
//  CNCTest
//
//  Created by 王国宇 on 2019/3/11.
//  Copyright © 2019 王国宇. All rights reserved.
//

import Foundation
class UserInfo:NSObject{
    var username:String = ""
    var avatar:String = ""
    init(name:String, logo:String){
        self.username = name
        self.avatar = logo
    }
}
