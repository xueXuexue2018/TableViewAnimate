//
//  BaseTableView.swift
//  Notepad
//
//  Created by juntuo on 2018/11/19.
//  Copyright © 2018 juntuo. All rights reserved.
//

import UIKit
class BaseTableView: UITableView {

    // 无数据占位图点击的回调函数
    var noContentViewTapedBlock:(() -> Void)?
    var noContentView : NoContentView!

    /**
     展示无数据占位图

     @param emptyViewType 无数据占位图的类型
     */
    func showEmptyViewWithType(emptyViewType: String) {
        // 如果已经展示无数据占位图，先移除
        if (noContentView != nil){
            noContentView.removeFromSuperview()
            noContentView = nil
        }

        //在创建
        noContentView = NoContentView(frame: self.bounds)
        self.addSubview(noContentView)

        noContentView.type = emptyViewType

        //添加单击手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(noContentViewDidTaped))

        noContentView.addGestureRecognizer(tap)
    }
    // 无数据占位图点击
    @objc private func noContentViewDidTaped(){
        if (self.noContentViewTapedBlock != nil) {//调用回调函数
            self.noContentViewTapedBlock?()
        }
    }
    /* 移除无数据占位图 */
    func removeEmptyView() {
        if (noContentView != nil) {
            noContentView.removeFromSuperview()
            noContentView = nil
        }

    }

}
