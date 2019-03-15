//
//  TableHeaderViewCell.swift
//  CNCTest
//
//  Created by 王国宇 on 2019/3/11.
//  Copyright © 2019 王国宇. All rights reserved.
//

import Foundation
import UIKit
class TableHeaderViewCell:UITableViewCell{
    var height:CGFloat = 30.0
    var label:UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(reuseIdentifier cellId:String) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: cellId)
    }
    class func getHeight() -> CGFloat {
        return 30.0
    }
    func setDate(_ value:Date){
        self.height = 30.0
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "yyyy年MM月dd日"
        dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        let text =  dateFormatter.string(from: value)
        if self.label != nil{
            self.label.text = text
            return
        }
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.label = UILabel(frame:CGRect(x: CGFloat(0), y: CGFloat(0), width: self.frame.size.width, height: height))
        self.label.text = text
        self.label.font = UIFont.boldSystemFont(ofSize: 12)
        
        self.label.textAlignment = NSTextAlignment.center
        self.label.shadowOffset = CGSize(width: 0, height: 1)
        self.label.shadowColor = UIColor.white
        self.label.textColor = UIColor.darkGray
        self.label.backgroundColor = UIColor.clear
        self.addSubview(self.label)
        
        
    }
}
