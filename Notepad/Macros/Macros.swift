//
//  Macros.swift
//  Notepad
//
//  Created by juntuo on 2018/11/19.
//  Copyright © 2018 juntuo. All rights reserved.
//

import UIKit
// MARK: - app全局
/// 屏幕宽度
let screenHeight = UIScreen.main.bounds.height
/// 屏幕高度
let screenWidth = UIScreen.main.bounds.width
/// 屏幕比例
let screenScale = screenWidth / 375.0  //相对于iphone6
// MARK: - 宽高
/// 状态栏高度
let heightStatusBar = UIApplication.shared.statusBarFrame.size.height
/// 导航栏高度
let heightNavBar: CGFloat = 44
/// app顶部高度(状态栏+导航栏)
let heightTop = heightStatusBar + heightNavBar
/// tabBar高度
let heightTabBar: CGFloat = 49
/// app底部高度
let heightBottom : CGFloat = (UIApplication.shared.statusBarFrame.size.height > 20) ? 83 : 49


// MARK: - 颜色
/// app主色(天蓝色)68A7F8
let colorApp = UIColor.colorWith(hexString: "68A7F8")
/// app背景色(浅灰白)F5F8FB
let colorAppBG = UIColor.colorWith(hexString: "F5F8FB")
/// 大标题(深黑)262C34
let colorBigTitle = UIColor.colorWith(hexString: "262C34")
/// 正文,副标题(深灰)575D6F
let colorText = UIColor.colorWith(hexString: "575D6F")
/// 辅助文字,说明(灰蓝)848FB3
let colorGrayBlue = UIColor.colorWith(hexString: "848FB3")
/// 次要信息(灰)ACBAC8
let colorGray = UIColor.colorWith(hexString: "ACBAC8")
/// 次要信息(浅灰蓝)DFDFDF
let colorGrayBlueLight = UIColor.colorWith(hexString: "DFDFDF")
/// 边框(浅灰)F5F8FB
let colorGrayLight = UIColor.colorWith(hexString: "F5F8FB")
/// 红FA6054
let colorRed = UIColor.colorWith(hexString: "FA6054")
/// 绿74BF57
let colorGreen = UIColor.colorWith(hexString: "74BF57")
/// 蓝317FE3
let colorBlue = UIColor.colorWith(hexString: "317FE3")
/// 橙FFA312
let colorOrange = UIColor.colorWith(hexString: "FFA312")
