//
//  TableViewCell.swift
//  CNCTest
//
//  Created by 王国宇 on 2019/3/11.
//  Copyright © 2019 王国宇. All rights reserved.
//

import Foundation
import UIKit
class TableViewCell:UITableViewCell {
    //消息内容视图
    var customView:UIView!
    //消息背景
    var bubbleImage:UIImageView!
    //头像
    var avatarImage:UIImageView!
    //消息结构
    var msgItem:MessageItem!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(data:MessageItem, reuseIdentifier cellId:String) {
        self.msgItem = data
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: cellId)
        rebuildUserInterface()
    }
    
    func rebuildUserInterface() {
        self.selectionStyle = UITableViewCellSelectionStyle.none
        if self.bubbleImage == nil {
            self.bubbleImage = UIImageView()
            self.addSubview(self.bubbleImage)
        }
        let type = self.msgItem.mtype
        let width = self.msgItem.view.frame.size.width
        let height = self.msgItem.view.frame.size.height
        var x = (type == ChatType.someone) ? 0 : self.frame.size.width - width - self.msgItem.insets.left - self.msgItem.insets.right
        var y:CGFloat = 0
        if self.msgItem.user.username != "" {
            let thisUser = self.msgItem.user
            let imageName = thisUser.avatar != "" ? thisUser.avatar : "noAvater.png"
            self.avatarImage = UIImageView(image: UIImage(named: imageName))
            
            self.avatarImage.layer.cornerRadius = 9.0
            self.avatarImage.layer.masksToBounds = true
            self.avatarImage.layer.borderColor = UIColor(white:0.0 ,alpha:0.2).cgColor
            self.avatarImage.layer.borderWidth = 1.0
            
            //用户头像在右 对方在左
            let avatarX = (type == ChatType.someone) ? 2 : self.frame.width - 52
            print(avatarX)
            //头像位于顶部
            let avaterY:CGFloat = 0
            self.avatarImage.frame = CGRect(x: avatarX, y: avaterY, width: 50, height: 50)
            self.addSubview(self.avatarImage)
            
            //若只有一行消息则将消息框居中
            let delta = (50 - (self.msgItem.insets.top
                + self.msgItem.insets.bottom + self.msgItem.view.frame.size.height))/2
            if (delta > 0) {
                y = delta
            }
            if (type == ChatType.someone) {
                x += 54
            }
            if (type == ChatType.mine) {
                x -= 54
            }
        }
        
        self.customView = self.msgItem.view
        self.customView.frame = CGRect(x: x + self.msgItem.insets.left,
                                       y: y + self.msgItem.insets.top, width: width, height: height)
        
        self.addSubview(self.customView)
        //如果是别人的消息，在左边，如果是我输入的消息，在右边
        if (type == ChatType.someone)
        {
            self.bubbleImage.image = UIImage(named:("yoububble.png"))!
                .stretchableImage(withLeftCapWidth: 21,topCapHeight:25)
            
        }
        else {
            self.bubbleImage.image = UIImage(named:"mebubble.png")!
                .stretchableImage(withLeftCapWidth: 15, topCapHeight:25)
        }
        self.bubbleImage.frame = CGRect(x: x, y: y,
                                        width: width + self.msgItem.insets.left + self.msgItem.insets.right,
                                        height: height + self.msgItem.insets.top + self.msgItem.insets.bottom)
    }
    
    //让单元格为屏幕宽
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.size.width = UIScreen.main.bounds.width
            super.frame = frame
        }
    }
    
}
