//
//  BaseTableViewCell.swift
//  Notepad
//
//  Created by juntuo on 2018/11/19.
//  Copyright © 2018 juntuo. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    let line = UIView()

    //xib创建
    override func awakeFromNib() {
        super.awakeFromNib()
        //取消cell的选中样式
        selectionStyle = .none

        //添加底部的线

        line.backgroundColor = colorGrayLight

        self.addSubview(line)

    }

    //缓存池创建
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //取消cell的选中样式
        selectionStyle = .none

        //添加底部的线

        line.backgroundColor = colorGrayLight

        self.addSubview(line)
    }

    //系统要求的自动生成的构造器
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //取消cell的选中样式
        selectionStyle = .none

        //添加底部的线

        line.backgroundColor = colorGrayLight

        self.addSubview(line)
    }

    weak var fatherVC: UIViewController?



    override func updateConstraints() {
        line.snp.makeConstraints{
            $0.left.equalTo(self).offset(screenScale * 20)
            $0.right.equalTo(self).offset(-screenScale * 20)
            $0.height.equalTo(1)
            $0.bottom.equalTo(self)
        }

        super.updateConstraints()
    }

}
