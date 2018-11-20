//
//  NoContentView.swift
//  Notepad
//
//  Created by juntuo on 2018/11/19.
//  Copyright © 2018 juntuo. All rights reserved.
//

import UIKit
import SnapKit
// 无数据占位图的类型
enum NoContentType:String {
    //无网络
    case NoContentTypeNetwork = "无网络"
    //无新闻
    case NoContentTypeNews = "无新闻"
}
class NoContentView: UIView {

    var imageView : UIImageView!
    var topLabel : UILabel!
    var bottomLabel : UILabel!
    /** 无数据占位图的类型 */
    var type :String?{
        willSet{
            if let newValue = newValue {
                switch newValue{
                case NoContentType.NoContentTypeNews.rawValue:
                    setImageTopLabelTextBottomLabelText(imageName: "wushuju", topLabelText: "暂时没有数据...", bottomLabelText: "点击重试")

                default:
                    setImageTopLabelTextBottomLabelText(imageName: "icon_wangluochucuo", topLabelText: "亲,你的网络出错啦~~~", bottomLabelText: "点击重试")
                }
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }

    private func setUpUI(){
        self.backgroundColor = UIColor.white
        //------图片----//
        imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        self.addSubview(imageView)

        //内容n描述
        topLabel = UILabel()
        self.addSubview(topLabel)
        topLabel.textAlignment = NSTextAlignment.center
        topLabel.font = UIFont.systemFont(ofSize: screenScale * 15)
        topLabel.textColor = colorText

        //提示点击重新加载
        bottomLabel = UILabel()
        self.addSubview(bottomLabel)
        bottomLabel.textAlignment = NSTextAlignment.center
        bottomLabel.font = UIFont.systemFont(ofSize: screenScale * 15)
        bottomLabel.textColor = colorText

        //建立约束
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-100)
            make.size.equalTo(150*screenScale)
        }

        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.right.equalTo(0)
            make.height.equalTo(20)
        }

        bottomLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom).offset(5)
            make.left.right.equalTo(0)
            make.height.equalTo(20)
        }

        /** 根据传入的值创建相应的UI */

    }

    //设置图片和文字
    private func setImageTopLabelTextBottomLabelText(imageName: String, topLabelText: String, bottomLabelText: String){
        imageView.image = UIImage(named:imageName)
        topLabel.text = topLabelText
        bottomLabel.text = bottomLabelText
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
