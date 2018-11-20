//
//  ViewController.swift
//  Notepad
//
//  Created by juntuo on 2018/11/19.
//  Copyright © 2018 juntuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dataSource:[Any] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "备忘录"

        createUI()
        createRightBarButton()
    }
    //
    private func createUI(){
        let tableView = AnimationTable()
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(0)
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {

            self.dataSource = [1,2,3,4,5,6,7,8,9]
            tableView.reloadData()
           /* case move
            case moveSpring
            case alpha
            case fallTop
            case fallBottom
            case shake
            case overTurn
            case toTop
            case springList
            case shrinkToTop
            case layDown
            case rote*/
             tableView.cellAnimationWithType(type:.custom, duration: 3)
            

        }
    }
    // 右边的编辑
    private func createRightBarButton(){
        let rightBar = UIBarButtonItem(title: "编辑", style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightEditAction))
        self.navigationItem.rightBarButtonItem = rightBar
        
    }
    @objc private func rightEditAction(){

    }


}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let index =  CGFloat(arc4random_uniform(255))/255.0

        cell.backgroundColor = UIColor(red: index, green: index, blue: index, alpha: 1)


        cell.textLabel?.text = "我是第\(indexPath.row)行"

        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let edit = EditViewController()
//        PushTransition.pushWithTransition(fromVC: self, toVC: edit, type: .scale, duration: 3)


        PresentTransition.presentWithAnimate(fromVC: self,toVC: edit,duration: 2, animate: .scale)


    }
    //可以被编辑
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // 要显示自定义的action,cell必须处于编辑状态
        return true
    }
    // 确定编辑模式（默认是滑动删除模式）
//    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle {
//        // 设置编辑模式为删除
//
//        return  UITableViewCell.EditingStyle.delete
//    }
     // 具体编辑操作（默认删除操作）
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

    }

    // 更多按钮设置
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // 分享项
        let shareAction = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) -> Void in
            // 选择分享目标
            let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .actionSheet)

            let twitterAction = UIAlertAction(title: "Twitter", style: .default, handler: nil)
            let facebookAction = UIAlertAction(title: "Facebook", style: .default, handler: nil)
            let emailAction = UIAlertAction(title: "Emain", style: .default, handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

            shareMenu.addAction(twitterAction)
            shareMenu.addAction(facebookAction)
            shareMenu.addAction(emailAction)
            shareMenu.addAction(cancelAction)

            print("分享")


        }

        // 删除项（实现了这个方法需要自己写删除项）
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) -> Void in
            // 从数据源中删除
            // ...

             print("删除")

        }

        // 设置背景色
        shareAction.backgroundColor = UIColor.orange
        deleteAction.backgroundColor = UIColor.blue

        return [shareAction, deleteAction]
    }

}

