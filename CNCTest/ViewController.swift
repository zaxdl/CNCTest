//
//  ViewController.swift
//  CNCTest
//
//  Created by 王国宇 on 2019/3/2.
//  Copyright © 2019 王国宇. All rights reserved.
//

import UIKit

import Starscream
class ViewController: UIViewController, UITextFieldDelegate,ChatDataSource,WebSocketDelegate{

    
    var w:CGFloat!
    var h:CGFloat!
    
    var ws:CGFloat!
    var hs:CGFloat!
    
    let th =  UIApplication.shared.statusBarFrame.height
    let MainWidth = UIScreen.main.bounds.width
    let MainHeight = UIScreen.main.bounds.height
    
    
    var txtUser:UITextField!
    var txtPwd:UITextField!
    
    //左手离脑袋的距离
    var offsetLeftHand:CGFloat = 60
    
    //左手图片,右手图片(遮眼睛的)
    var imgLeftHand:UIImageView!
    var imgRightHand:UIImageView!
    
    //左手图片,右手图片(圆形的)
    var imgLeftHandGone:UIImageView!
    var imgRightHandGone:UIImageView!
    
    //登录框状态
    var showType:LoginShowType = LoginShowType.NONE
    
    var bfb:UIView!
    
    
    var ed:UITextField!
    //tcp
    var socket:GCDAsyncSocket?
    var beatTimer = Timer()
    
    //聊天界面
    var Chats:NSMutableArray!
    var tableView:TableView!
    var me:UserInfo!
    var you:UserInfo!
    var txtMsg:UITextField!
    
    var webSocket:WebSocket!
    
    
    let queue = DispatchQueue(label: "queueName", attributes: .concurrent)

    var dataModel = DataModel()
    
    let nowTimes = Date()
    //socket
    let zone = NSTimeZone.system
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let a = OProgressView2()
//        a.setProgress(60, animated: false)
//        self.view.addSubview(a)
//        let main = UIView(frame: CGRect(x: 100, y: 100, width: 180, height: 200))
//        main.backgroundColor = .green
//        main.layer.cornerRadius = 10
//        self.view.addSubview(main)
//
        
        
//        let btn = UIView(frame: CGRect(x: 0, y: 120, width: 120, height: 40))
//        btn.backgroundColor = .blue
//        SetMutiBorderRoundingCorners(btn, corner: 10)
//        main.addSubview(btn)
        
//        w = self.view.bounds.width
//        h = self.view.bounds.height-th
//        ws = 200
//        hs = h/10
//
//        let shopView = UIView(frame: CGRect(x: ws, y: th, width: w-ws, height: h))
//        shopView.backgroundColor = .green
//        self.view.addSubview(shopView)
//
//        let shopChild = UIView(frame: CGRect(x: 20, y: 182, width: w-ws-40, height: h-40-162))
//        shopChild.backgroundColor = .white
//        shopView.addSubview(shopChild)
//        print(w-ws-40)
//        print(h-40-162)
//
//        let ww:CGFloat = w-ws-40
//        let hh:CGFloat = h-202
//
//        let wc:CGFloat = 180
//        let hc:CGFloat = 240
//
//
//
//        let testW:Int = Int(ww)/Int(wc)
//        let testH:Int = Int(hh)/Int(hc)
//        print(testW,",",testH)
//
//        let wLine = (ww-(CGFloat(testW)*wc))/CGFloat(testW+1)
//        let hLine = (hh-(CGFloat(testH)*hc))/CGFloat(testH+1)
//
//        for i in 0..<testH {
//            for j in 0..<testW {
//                let test = UIView(frame: CGRect(x: wLine+CGFloat(j)*(wLine+wc), y: hLine+CGFloat(i)*(hLine+hc), width: wc, height: hc))
//                test.backgroundColor = .blue
//                //shopChild.addSubview(test)
//                let t = UIView(frame: CGRect(x: 0, y: 180, width: 180, height: 60))
//                t.backgroundColor = .red
//                //test.addSubview(t)
//            }
//        }
        
        
        
        
//        //二维码生成
//        let url = "https://www.jianshu.com/u/01b7a2dd26e8"
//        let headerImage = UIImage(named: "title")
//        var t = UIImageView(frame: CGRect(x: 10, y: 10, width: 200, height: 200))
//        t.image = setupQRCodeImage(url, image: headerImage)
//        self.view.addSubview(t)
        
        
        
        /*
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.setTitle("sss", for: .normal)
        btn.backgroundColor = .yellow
        btn.addTarget(self, action: #selector(check), for: .touchUpInside)
        self.view.addSubview(btn)
        
        
        let batteryView = UIView(frame: CGRect(x: UIScreen.main.bounds.width-180, y: 50, width: 100, height: 15))
        //batteryView.backgroundColor = .yellow
        batteryView.layer.borderWidth = 1
        batteryView.layer.borderColor =  UIColor.colorWithHexString("f5f5f5").cgColor
        batteryView.layer.cornerRadius = 7.5
        batteryView.clipsToBounds = true

        self.view.addSubview(batteryView)
        
        bfb = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 15))
        bfb.backgroundColor = UIColor.colorWithRGB(r: 135, g: 206, b: 250, alpha: 0.8)
        bfb.layer.cornerRadius = 7.5
        bfb.clipsToBounds = true
        batteryView.addSubview(bfb)
        
        let t = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 15))
        t.text = "10/100"
        t.font = UIFont.systemFont(ofSize: 12)
        t.textAlignment = .center
        batteryView.addSubview(t)
 */
        
        
        
        ///=========TCP连接==================
        
//        let btn = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 50))
//        btn.setTitle("连接TCP", for: .normal)
//        btn.backgroundColor = .blue
//        btn.addTarget(self, action: #selector(getSocket), for: .touchUpInside)
//        self.view.addSubview(btn)
//
//        let send = UIButton(frame: CGRect(x: 250, y: 200, width: 100, height: 50))
//        send.setTitle("发送", for: .normal)
//        send.backgroundColor = .blue
//        send.addTarget(self, action: #selector(sendData), for: .touchUpInside)
//        self.view.addSubview(send)
//
//        ed = UITextField(frame: CGRect(x: 200, y: 260, width: 250, height: 150))
//        ed.backgroundColor = .lightGray
//        ed.textColor = .black
//        self.view.addSubview(ed)
        //==================================
        
        
        //聊天界面
        setupChatTable()
        setupSendPanel()
        //getWebSocket()
        //getSocket()
    }
    
    
    func setupSendPanel(){
        let screenWidth = UIScreen.main.bounds.width
        let sendView = UIView(frame:CGRect(x: 0,y: self.view.frame.size.height - 56,width: screenWidth,height: 56))
        
        sendView.backgroundColor=UIColor.lightGray
        sendView.alpha=0.9
        
        txtMsg = UITextField(frame:CGRect(x: 7,y: 10,width: screenWidth - 95,height: 36))
        txtMsg.backgroundColor = UIColor.white
        txtMsg.textColor=UIColor.black
        txtMsg.font=UIFont.boldSystemFont(ofSize: 12)
        txtMsg.layer.cornerRadius = 10.0
        txtMsg.returnKeyType = UIReturnKeyType.send
        txtMsg.delegate=self
        sendView.addSubview(txtMsg)
        self.view.addSubview(sendView)
        
        let sendButton = UIButton(frame:CGRect(x: screenWidth - 80,y: 10,width: 72,height: 36))
        sendButton.backgroundColor=UIColor(red: 0x37/255, green: 0xba/255, blue: 0x46/255, alpha: 1)
        sendButton.addTarget(self, action:#selector(sendMessage) ,
                             for:UIControlEvents.touchUpInside)
        sendButton.layer.cornerRadius=6.0
        sendButton.setTitle("发送", for:UIControlState())
        sendView.addSubview(sendButton)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
    
    
    @objc func sendMessage(){
        let sender = txtMsg
        let thisChat = MessageItem(body: sender?.text as! NSString, user: me, date: Date(timeIntervalSinceNow: 0), mtype: ChatType.mine)
        
        let interval = self.zone.secondsFromGMT()
        let timeInterval:TimeInterval = Date().timeIntervalSince1970
        let sendTime = Double(interval)+Double(timeInterval)
        
        self.dataModel.userList.append(UserInfoData(name: "me", data: (txtMsg?.text?.description)!, time: sendTime.description))
        dataModel.saveData()
        Chats.add(thisChat)
        webSocket.write(string: (sender?.text)!)
        //Chats.add(thatChat)
        self.tableView.chatDataSource = self
        self.tableView.reloadData()
        
        sender?.resignFirstResponder()
        sender?.text = ""
    }
    func setupChatTable(){
        self.tableView = TableView(frame:CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: self.view.frame.size.height - 76), style: .plain)
        
        //创建一个重用的单元格
        self.tableView!.register(TableViewCell.self, forCellReuseIdentifier: "ChatCell")
        me = UserInfo(name:"Xiaoming" ,logo:("user_icon"))
        you  = UserInfo(name:"Xiaohua", logo:("sale_icon"))
        
        var msg = [MessageItem]()
        msg.removeAll()
        
        dataModel.loadData()
        print("这是聊天记录",dataModel.userList.description)
        if dataModel.userList.count > 1 {
        for i in 0..<dataModel.userList.count {
            if dataModel.userList[i].name == "me" {
                let interval = zone.secondsFromGMT()
                let nowtimedata = Date().timeIntervalSince1970
                let nowsss = Double(interval)+Double(nowtimedata)
                
                
                let lt = MessageItem(body: dataModel.userList[i].data as NSString, user: me, date: Date(timeIntervalSinceNow: Double(dataModel.userList[i].time)!-nowsss), mtype: .mine)
                msg.append(lt)
                print(Date(timeIntervalSinceNow: Double(dataModel.userList[i].time)!-nowtimedata+Double(interval)),dataModel.userList[i].time)
                
            }else {
                let interval = zone.secondsFromGMT()
                let nowtimedata = Date().timeIntervalSince1970
                let nowsss = Double(interval)+Double(nowtimedata)
                let lt = MessageItem(body: dataModel.userList[i].data as NSString, user: you, date: Date(timeIntervalSinceNow: Double(dataModel.userList[i].time)!-nowsss), mtype: .someone)
                msg.append(lt)
            }
        }
        }
        

        
        let first =  MessageItem(body:"欢迎使用CNC", user:you,  date:Date(timeIntervalSinceNow:0), mtype:.someone)
        msg.append(first)
        Chats = NSMutableArray()
        Chats.addObjects(from: msg)
        //Chats.removeAllObjects()
        
        //set the chatDataSource
        self.tableView.chatDataSource = self
        
        //call the reloadData, this is actually calling your override method
        self.tableView.reloadData()

        self.view.addSubview(self.tableView)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.005) {
            self.tableView.scrollToRow(at: IndexPath(row: self.Chats.count, section: 0), at: .bottom, animated: false)
        }
        
    }
    
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////                        if self.isScrollBottom { //只在初始化的时候执行
////                                    let popTime = DispatchTime.now() + 0.005 //延迟执行5毫秒
////                                    DispatchQueue.main.asyncAfter(deadline: popTime) {
////                                                if self.messageModelArray.count > 0 {
////  tableView.scrollToRow(at: IndexPath(row: self.messageModelArray.count - 1, section: 0), at: .bottom, animated: false)
////                                                    }
////                                        }
////                            }
////                        return self.messageModelArray.count
//    }


    
    
    
    func rowsForChatTable(_ tableView: TableView) -> Int {
        return self.Chats.count
    }
    
    func chatTableView(_ tableView: TableView, dataForRow: Int) -> MessageItem {
         return Chats[dataForRow] as! MessageItem
    }
    
    
    ///=========================================================
    @objc func getSocket(){
        print("send")
        socket = GCDAsyncSocket()
        socket?.delegate = self
        socket?.delegateQueue = DispatchQueue.global()
        do {
            try socket?.connect(toHost: "192.168.50.46", onPort: 1612)
        }catch _ {
            print("try connect error:")
        }
    }
    
    //==============================
    func getWebSocket(){
        //ws://jccnccloud.applinzi.com/webSocket/chat/jc
        //ws://121.40.165.18:8800
        webSocket = WebSocket(url: URL(string: "ws://jccnccloud.applinzi.com/webSocket/chat/jc")!)
        webSocket.delegate = self as! WebSocketDelegate
        webSocket.connect()
    }
    
    @objc func sendData(){
        socket?.write("nihao".data(using: .utf8)!, withTimeout: -1, tag: 0)
    }
    
    //心跳包
    func socketDidConnectBeginSendBeat() -> Void {
        beatTimer = Timer.scheduledTimer(timeInterval: 0.05,
                                         target: self,
                                         selector: #selector(sendBeat),
                                         userInfo: nil,
                                         repeats: true)
        RunLoop.current.add(beatTimer, forMode: RunLoopMode.commonModes)
    }
    // 向服务器发送心跳包
    @objc func sendBeat() {
        socket?.write("aa".data(using: .utf8)!, withTimeout: -1, tag: 0)
        self.socket!.readData(to: GCDAsyncSocket.crlfData(), withTimeout: -1, tag: 0)
    }
    
    

    
    @objc func check(){
        change(i: 10)
    }
    
    
    func change(i:Float){
        UIView.animate(withDuration: 1) {
            self.bfb.transform = CGAffineTransform.identity.translatedBy(x: -CGFloat((100-i)/200*100), y: 0).scaledBy(x: CGFloat(i/100), y: 1)
        }
    }
    
    
    
    
    
    
    
    
    
    
    func SetMutiBorderRoundingCorners(_ view:UIView,corner:CGFloat)
    {
        let maskPath = UIBezierPath.init(roundedRect: view.bounds,
                                         byRoundingCorners: [UIRectCorner.bottomLeft, UIRectCorner.bottomRight],
                                         cornerRadii: CGSize(width: corner, height: corner))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        view.layer.mask = maskLayer
    }
    
    
    func setupQRCodeImage(_ text: String, image: UIImage?) -> UIImage {
        //创建滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        //将url加入二维码
        filter?.setValue(text.data(using: String.Encoding.utf8), forKey: "inputMessage")
        //取出生成的二维码（不清晰）
        if let outputImage = filter?.outputImage {
            //生成清晰度更好的二维码
            let qrCodeImage = setupHighDefinitionUIImage(outputImage, size: 300)
            //如果有一个头像的话，将头像加入二维码中心
            if var image = image {
                //给头像加一个白色圆边（如果没有这个需求直接忽略）
                image = circleImageWithImage(image, borderWidth: 50, borderColor: UIColor.white)
                //合成图片
                let newImage = syntheticImage(qrCodeImage, iconImage: image, width: 100, height: 100)
                
                return newImage
            }
            
            return qrCodeImage
        }
        
        return UIImage()
    }
    
    //image: 二维码 iconImage:头像图片 width: 头像的宽 height: 头像的宽
    func syntheticImage(_ image: UIImage, iconImage:UIImage, width: CGFloat, height: CGFloat) -> UIImage{
        //开启图片上下文
        UIGraphicsBeginImageContext(image.size)
        //绘制背景图片
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let x = (image.size.width - width) * 0.5
        let y = (image.size.height - height) * 0.5
        iconImage.draw(in: CGRect(x: x, y: y, width: width, height: height))
        //取出绘制好的图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        //返回合成好的图片
        if let newImage = newImage {
            return newImage
        }
        return UIImage()
    }
    
    //MARK: - 生成高清的UIImage
    func setupHighDefinitionUIImage(_ image: CIImage, size: CGFloat) -> UIImage {
        let integral: CGRect = image.extent.integral
        let proportion: CGFloat = min(size/integral.width, size/integral.height)
        
        let width = integral.width * proportion
        let height = integral.height * proportion
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImage = context.createCGImage(image, from: integral)!
        
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: proportion, y: proportion);
        bitmapRef.draw(bitmapImage, in: integral);
        let image: CGImage = bitmapRef.makeImage()!
        return UIImage(cgImage: image)
    }
    
    //生成边框
    func circleImageWithImage(_ sourceImage: UIImage, borderWidth: CGFloat, borderColor: UIColor) -> UIImage {
        let imageWidth = sourceImage.size.width + 2 * borderWidth
        let imageHeight = sourceImage.size.height + 2 * borderWidth
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imageWidth, height: imageHeight), false, 0.0)
        UIGraphicsGetCurrentContext()
        
        let radius = (sourceImage.size.width < sourceImage.size.height ? sourceImage.size.width:sourceImage.size.height) * 0.5
        let bezierPath = UIBezierPath(arcCenter: CGPoint(x: imageWidth * 0.5, y: imageHeight * 0.5), radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        bezierPath.lineWidth = borderWidth
        borderColor.setStroke()
        bezierPath.stroke()
        bezierPath.addClip()
        sourceImage.draw(in: CGRect(x: borderWidth, y: borderWidth, width: sourceImage.size.width, height: sourceImage.size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func changeData(data:String){
        print("jiazai")
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                //let now = Date()
                let interval = self.zone.secondsFromGMT()
                let timeInterval:TimeInterval = Date().timeIntervalSince1970
                let sendTime = Double(interval)+Double(timeInterval)
                let splitedArray = data.components(separatedBy: ":")
                self.dataModel.userList.append(UserInfoData(name: "sale", data: splitedArray.last!, time: sendTime.description))
                self.dataModel.saveData()
                let thatChat = MessageItem(body: splitedArray.last! as NSString, user:self.you, date:Date(), mtype:ChatType.someone)
                self.Chats.add(thatChat)
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    //websocket
    func websocketDidConnect(socket: WebSocketClient) {
        print("connect")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("faile")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print(text)
        changeData(data: text)
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("这是",data)
    }
    


}

extension ViewController: GCDAsyncSocketDelegate {
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print(host)
        print("connect success")
        socketDidConnectBeginSendBeat()
        self.socket?.readData(withTimeout: -1, tag: 0)
        self.socket?.write(GCDAsyncSocket.crlfData(), withTimeout: -1, tag: 0)
    }
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        
        let msg = String(data: data, encoding: .utf8)
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                let thatChat = MessageItem(body:msg! as NSString, user:self.you, date:Date(), mtype:ChatType.someone)
                self.Chats.add(thatChat)
                self.tableView.reloadData()
            }
        }
        
        
        socket?.readData(withTimeout: -1, tag: 0)
        self.socket?.write(GCDAsyncSocket.crlfData(), withTimeout: -1, tag: 0)
        
    }
    
    
    
    
    
}

enum LoginShowType {
    case NONE
    case USER
    case PASS
}
