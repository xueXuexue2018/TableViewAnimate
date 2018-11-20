//
//  UIColor.swift
//  Notepad
//
//  Created by juntuo on 2018/11/19.
//  Copyright © 2018 juntuo. All rights reserved.
//

import UIKit
extension UIColor{
    /// 通过RGB返回颜色
    ///
    /// - Parameters:
    ///   - r: 红色系数最大为255
    ///   - g: 绿色系数最大为255
    ///   - b: 蓝色系数最大为255
    ///   - alpha: 透明度0~1
    /// - Returns: 合成颜色
    @objc class func colorWith(r: Int, g: Int, b: Int, alpha: CGFloat = 1.0) -> UIColor {
        let color = UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
        return color
    }

    //@objc是把这个方法暴露给OC文件使用,不然oc文件是使用不了的
    /// 通过十六进制返回颜色
    ///
    /// - Parameters:
    ///   - hexString: 十六进制系数字符串
    ///   - alpha: 透明度
    /// - Returns: 颜色,输入无效十六进制值则返回黑色
    @objc class func colorWith(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            return UIColor.black
        }
    }


    /// 返回随机色
    ///
    /// - Returns: 随机色
    @objc class func randomColor() -> UIColor {
        let color = UIColor.colorWith(r: Int(arc4random_uniform(256)), g: Int(arc4random_uniform(256)), b: Int(arc4random_uniform(256)), alpha: 1)
        return color
    }


    /// 通过颜色返回一张图片
    ///
    /// - Returns: UIImage
    @objc func toImage() -> UIImage? {

        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}
