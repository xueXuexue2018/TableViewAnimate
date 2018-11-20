//
//  EditViewController.swift
//  Notepad
//
//  Created by juntuo on 2018/11/19.
//  Copyright © 2018 juntuo. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)

        let v = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        self.view.addSubview(v)
        v.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)

        v.layer.add(showAnimate(), forKey: "animate")
        // Do any additional setup after loading the view.
    }

    func showAnimate()->CABasicAnimation{
        let animate = Animation.baseAnimationWithKeyPath("transform.rotation.z", fromValue: nil, toValue: 2 * M_PI, duration: 10, repeatCount: nil, timingFunction: CAMediaTimingFunctionName.linear.rawValue)

        return animate

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true){}
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
