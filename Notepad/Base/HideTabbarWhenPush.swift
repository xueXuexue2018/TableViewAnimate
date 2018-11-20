//
//  HideTabbarWhenPush.swift
//  Notepad
//
//  Created by juntuo on 2018/11/19.
//  Copyright © 2018 juntuo. All rights reserved.
//

import UIKit

class HideTabbarWhenPush: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.hidesBackButton=true

        if children.count>0{

                UINavigationBar.appearance().backItem?.hidesBackButton=false

            viewController.hidesBottomBarWhenPushed=true
        }
        super.pushViewController(viewController, animated: animated)
    }

}
