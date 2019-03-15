//
//  ChatWebSocket.swift
//  CNCTest
//
//  Created by 王国宇 on 2019/3/13.
//  Copyright © 2019 王国宇. All rights reserved.
//

import Foundation
import UIKit
import Starscream
@objc public protocol JCWebSocketDelegate: NSObjectProtocol{
    @objc optional func webSocketDidConnect(socket: JCWebSocket)
    @objc optional func webSocketDidDisCounnect(socket: JCWebSocket, error: NSError?)
    func websocketDidReceiveMessage(socket: JCWebSocket, text: String)
    @objc optional  func  websocketDidReceiveData(socket: JCWebSocket, data: NSData)
}
public class JCWebSocket: NSObject,WebSocketDelegate {
    var socket:WebSocket!
    weak var webSocketDelegate: JCWebSocketDelegate?
    
    class func sharedInstance() -> JCWebSocket{
        return manger
    }
    //MARK:- 链接服务器
    func connectSever(){
        socket = WebSocket(url: NSURL(string: 你的URL网址如：ws://192.168.3.209:8080/shop))
            socket.delegate = self
            socket.connect()
    }
    
    //发送文字消息
    func sendBrandStr(brandID:String){
        socket.writeString(brandID))
    }
    //MARK:- 关闭消息
    func disconnect(){
        socket.disconnect()
    }
    
    public func websocketDidConnect(socket: WebSocketClient) {
        <#code#>
    }
    
    public func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        <#code#>
    }
    
    public func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        <#code#>
    }
    
    public func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        <#code#>
    }
}

