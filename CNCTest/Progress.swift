//
//  Progress.swift
//  CNCTest
//
//  Created by 王国宇 on 2019/3/2.
//  Copyright © 2019 王国宇. All rights reserved.
//

import Foundation
import UIKit
class Progress: UIView {
    
    struct Constant {
        static let lineWidth:CGFloat = 10
        static let trackColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        static let progressColor = UIColor.orange
    }
    
    let trackLayer = CAShapeLayer()
    let progressLayer = CAShapeLayer()
    let path = UIBezierPath()
    var dot:UIView!
    
    var progressCenter:CGPoint {
        get{
            return CGPoint(x: bounds.midX, y: bounds.midY)
        }
    }
    
    var radius:CGFloat{
        get{
            return bounds.size.width/2 - Constant.lineWidth
        }
    }
    
    @IBInspectable var progress: Int = 0 {
        didSet {
            if progress > 100 {
                progress = 100
            }else if progress < 0 {
                progress = 0
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        path.addArc(withCenter: progressCenter, radius: radius,
                    startAngle: angleToRadian(-90), endAngle: angleToRadian(270), clockwise: true)
        
        //绘制进度槽
        trackLayer.frame = bounds
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = Constant.trackColor.cgColor
        trackLayer.lineWidth = Constant.lineWidth
        trackLayer.path = path.cgPath
        layer.addSublayer(trackLayer)
        
        //绘制进度条
        progressLayer.frame = bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = Constant.progressColor.cgColor
        progressLayer.lineWidth = Constant.lineWidth
        progressLayer.path = path.cgPath
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = CGFloat(progress)/100.0
        layer.addSublayer(progressLayer)
        
        //绘制进度条头部圆点
        dot = UIView(frame:CGRect(x: 0, y: 0, width: Constant.lineWidth,
                                  height: Constant.lineWidth))
        let dotPath = UIBezierPath(ovalIn:
            CGRect(x: 0,y: 0, width: Constant.lineWidth, height: Constant.lineWidth)).cgPath
        let arc = CAShapeLayer()
        arc.lineWidth = 0
        arc.path = dotPath
        arc.strokeStart = 0
        arc.strokeEnd = 1
        arc.strokeColor = Constant.progressColor.cgColor
        arc.fillColor = Constant.progressColor.cgColor
        arc.shadowColor = UIColor.black.cgColor
        arc.shadowRadius = 5.0
        arc.shadowOpacity = 0.5
        arc.shadowOffset = CGSize.zero
        dot.layer.addSublayer(arc)
        dot.layer.position = calcCircleCoordinateWithCenter(progressCenter, radius: radius, angle: CGFloat(-progress)/100*360+90)
        addSubview(dot)
    }
    
    func setProgress(_ pro: Int,animated anim: Bool){
        setProgress(pro, animated: anim, withDuration: 0.55)
    }
    
    
    func setProgress(_ pro: Int,animated anim:Bool, withDuration duration:Double) {
        let oldProgress = progress
        progress = pro
        CATransaction.begin()
        CATransaction.setDisableActions(!anim)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        CATransaction.setAnimationDuration(duration)
        progressLayer.strokeEnd = CGFloat(progress)/100.0
        CATransaction.commit()
        
        let startAngle = angleToRadian(360*Double(oldProgress)/100 - 90)
        let endAngle = angleToRadian(360*Double(progress)/100 - 90)
        let clockWise = progress > oldProgress ? false : true
        let path2 = CGMutablePath()
        path2.addArc(center: CGPoint(x:bounds.midX,y: bounds.midY),
                     radius: bounds.size.width/2 - Constant.lineWidth,
                     startAngle: startAngle, endAngle: endAngle,
                     clockwise: clockWise, transform: transform)
        
        let orbit = CAKeyframeAnimation(keyPath:"position")
        orbit.duration = duration
        orbit.path = path2
        orbit.calculationMode = kCAAnimationPaced
        orbit.timingFunction =
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        orbit.isRemovedOnCompletion = false
        orbit.fillMode = kCAFillModeForwards
        dot.layer.add(orbit,forKey:"Move")
        
    }
    
    fileprivate func angleToRadian(_ angle: Double) ->CGFloat{
        return CGFloat(angle/Double(180.0) * M_PI)
    }
    
    func calcCircleCoordinateWithCenter(_ center:CGPoint, radius:CGFloat, angle:CGFloat) -> CGPoint {
        let x2 = radius*CGFloat(cosf(Float(angle)*Float(M_PI)/Float(180)))
        let y2 = radius*CGFloat(sinf(Float(angle)*Float(M_PI)/Float(180)))
        return CGPoint(x: center.x+x2, y: center.y-y2)
    }
    
}
