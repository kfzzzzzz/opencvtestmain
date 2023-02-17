//
//  Utils.swift
//  opencv-test-main
//
//  Created by 孔繁臻 on 2/10/23.
//

import Foundation
import UIKit

func allFont() {
    //遍历所有字体，这时已经把新字体添加进去了
    for fontfamilyname in UIFont.familyNames {
        print("family:'\(fontfamilyname)'")
        for fontName in UIFont.fontNames(forFamilyName: fontfamilyname) {
            print("\tfont:'\(fontName)'")
        }
        print("-------------")
    }
}

// 设备屏幕宽
public let ScreenW = UIScreen.main.bounds.width
// 设备屏幕高
public let ScreenH = UIScreen.main.bounds.height

// tabbar突出高度度 20
public let standOutHeight: CGFloat = padSize(28.atScale(), withPhoneSize: 28.atScale())


// 画tabBar背景
func drawTabBarImageView() -> UIImageView{
    // 标签栏的高度
    let TabBarHeight: CGFloat = getTabBarHeight()

    
    let imageView = UIImageView.init(frame: CGRect(x: 0, y: -standOutHeight, width: ScreenW, height: TabBarHeight + standOutHeight))
    
    let pointCount:Int = 2
    let pointArr:NSMutableArray = NSMutableArray.init()
    for i in 0...pointCount {
        let px: CGFloat = CGFloat(111).atScale() + CGFloat(i) * CGFloat(76.5).atScale()
        let py: CGFloat = i % 2 == 0 ? standOutHeight : 0
        let point: CGPoint = CGPoint.init(x: px, y: py)
        pointArr.add(point)
    }
    
    let bezierPath = UIBezierPath()
   // bezierPath.lineWidth = 2.0
    var prevPoint: CGPoint!
    
    for i in 0 ..< pointArr.count {
        let currPoint:CGPoint = pointArr.object(at: i) as! CGPoint
        
        // 绘制平滑曲线
        if i==0 {
            bezierPath.move(to: currPoint)
        }
        else {
            let conPoint1: CGPoint = CGPoint.init(x: CGFloat(prevPoint.x + currPoint.x) / 2.0, y: prevPoint.y)
            let conPoint2: CGPoint = CGPoint.init(x: CGFloat(prevPoint.x + currPoint.x) / 2.0, y: currPoint.y)
            bezierPath.addCurve(to: currPoint, controlPoint1: conPoint1, controlPoint2: conPoint2)
        }
        prevPoint = currPoint
    }
    bezierPath.stroke()
    
//    let size = imageView.frame.size
//
//
   let layer = CAShapeLayer.init()
//    let path = UIBezierPath.init()
//    path.move(to: CGPoint(x: (size.width/2) - ww, y: standOutHeight))
//    // 开始画弧：CGPointMake：弧的圆心  radius：弧半径 startAngle：开始弧度 endAngle：介绍弧度 clockwise：YES为顺时针，No为逆时针
//    path.addArc(withCenter: CGPoint(x: (size.width/2), y: radius), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
//    //开始画弧以外的部分
//    path.addLine(to: CGPoint(x: size.width/2 + ww, y: standOutHeight))
//    path.addLine(to: CGPoint(x: size.width, y: standOutHeight))
//    path.addLine(to: CGPoint(x: size.width, y: size.height))
//    path.addLine(to: CGPoint(x: 0, y: size.height))
//    path.addLine(to: CGPoint(x: 0, y: standOutHeight))
//    path.addLine(to: CGPoint(x: size.width/2 - ww, y: standOutHeight))
    layer.path = bezierPath.cgPath

    layer.fillColor = UIColor(hex: 0xF22E63).cgColor
    //layer.strokeColor = UIColor.init(white: 0.765, alpha: 1.0).cgColor
    //layer.lineWidth = 0.5
    imageView.layer.addSublayer(layer)
    //imageView.backgroundColor = UIColor(hex: 0xF22E63)
    return imageView
}




// 获取Tab的高，主要是X和其他设备不同
func getTabBarHeight() -> (CGFloat){
    let tabBarController = UITabBarController()
    let height = tabBarController.tabBar.bounds.height
    let dv: UIDevice = UIDevice.current
    print("设备信息：\(dv.localizedModel)")
    if (UIScreen.main.bounds.height >= 812){
        return 83.atScale()
    } else {
        return height.atScale()
    }
}


func at_scale() -> CGFloat {
    let screenSize = UIScreen.main.bounds.size
    var scaleBase: CGFloat = 0
    if isPad {
        scaleBase = max(screenSize.width, screenSize.height)
        return scaleBase/1024.0
    } else {
        scaleBase = min(screenSize.width, screenSize.height)
        return scaleBase/375.0
    }
}

public var isPad: Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}

extension CGFloat {
    public func atScale() -> CGFloat {
        return self * at_scale()
    }
}

extension Int {
    public func atScale() -> CGFloat {
        return CGFloat(self) * at_scale()
    }
}

extension Double {
    public func atScale() -> CGFloat {
        return CGFloat(self) * at_scale()
    }
}

func padSize(_ padSize: CGFloat, withPhoneSize phoneSize: CGFloat) -> CGFloat {
    if UIDevice.current.userInterfaceIdiom == .pad {
        return padSize
    }
    return phoneSize
}

/**
     ** 绘图方式将图片裁剪成圆角并添加边框
     - imageName --传头头像名称
     - borderWidth --边框大小
     - borderColor --边框颜色
     */
    public func tailoringImageLayer(_ image: UIImage,borderWidth width:CGFloat,borderColor color: UIColor ) -> UIImage? {
        //1.先开启一个图片上下文 ,尺寸大小在原始图片基础上宽高都加上两倍边框宽度.
        let imageSize = CGSize(width: image.size.width + width * 2 , height: image.size.height + width * 2)
        UIGraphicsBeginImageContext(imageSize)
        //2.填充一个圆形路径.这个圆形路径大小,和上下文尺寸大小一样.
        //把大圆画到上下文当中.
        let path = UIBezierPath(ovalIn: CGRect(x: 0,
                                               y: 0,
                                               width: imageSize.width,
                                               height: imageSize.height))
        //颜色设置
        color.set()
        //填充
        path.fill()
        //3.添加一个小圆,小圆,x,y从边框宽度位置开始添加,宽高和原始图片一样大小.把小圆设为裁剪区域.
        let clipPath = UIBezierPath(ovalIn: CGRect(x: width, y: width, width: image.size.width, height: image.size.height))
        //把小圆设为裁剪区域.
        clipPath.addClip()
        //4.把图片给绘制上去.
        image.draw(at: CGPoint(x: width, y: width))
        //5.从上下文当中生成一张图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //6.关闭上下文
        UIGraphicsEndImageContext()
        return  newImage
    }
    /**
     ** 异步绘图方式将图片裁剪成圆角并添加边框
     - imageName --传头头像名称
     - borderWidth --边框大小
     - borderColor --边框颜色
     - parameter completed:    异步完成回调(主线程回调)
     */
    public func async_tailoringImageLayer(_ image: UIImage,borderWidth width:CGFloat,borderColor color: UIColor ,completed:@escaping (UIImage?) -> ()) -> Void {
        DispatchQueue.global().async{
            let newImage = tailoringImageLayer(image, borderWidth: width, borderColor: color)
            DispatchQueue.main.async(execute: {
                completed(newImage)
            })
        }
    }
