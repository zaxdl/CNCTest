//
//  ChartDataSource.swift
//  CNCTest
//
//  Created by 王国宇 on 2019/3/11.
//  Copyright © 2019 王国宇. All rights reserved.
//

import Foundation
protocol ChatDataSource {
    //记录全部行数
    func rowsForChatTable( _ tableView:TableView) -> Int
    //记录某行数据
    func chatTableView(_ tableView:TableView, dataForRow:Int)-> MessageItem
}
