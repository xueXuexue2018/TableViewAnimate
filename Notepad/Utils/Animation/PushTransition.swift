//
//  PushTransition.swift
//  Notepad
//
//  Created by juntuo on 2018/11/20.
//  Copyright © 2018 juntuo. All rights reserved.
//

import UIKit

class PushTransition: NSObject {
    enum `Type` {
        case scale
        case fromTop
        case fromLeft
        case fromRight

    }
    static private var duration = 0.5
    static private var type: Type = .scale
    // 设置转场代理
    static var transition = PushTransition()
    static func pushWithTransition(fromVC: UIViewController,
                                   toVC: UIViewController,
                                   type: Type = .scale,
                                   duration: Double = 0.5) {
        self.type = type
        self.duration = duration
        fromVC.navigationController?.delegate = PushTransition.transition as! UINavigationControllerDelegate
        fromVC.navigationController?.pushViewController(toVC, animated: true)
        fromVC.navigationController?.delegate = nil
    }
}
extension PushTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
         return PushTransition.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.view(forKey: .to)
        let fromVC = transitionContext.view(forKey: .from)
        guard let fromView = fromVC, let toView = toVC else {
            return
        }
        switch PushTransition.type {
        case .scale:
            scalePush(fromView: fromView, toView: toView, transitionContext: transitionContext)
        case .fromTop:
            fromTopPush(fromView: fromView, toView: toView, transitionContext: transitionContext)

        case .fromLeft:
            fromLeftPush(fromView: fromView, toView: toView, transitionContext: transitionContext)
        case .fromRight:
            fromRightPush(fromView: fromView, toView: toView, transitionContext: transitionContext)
        }
    }

}
extension PushTransition: UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return PushTransition()
    }
}
extension PushTransition{
    private func scalePush(fromView: UIView,
                           toView: UIView,
                           transitionContext: UIViewControllerContextTransitioning){
        transitionContext.containerView.addSubview(toView)
        transitionContext.containerView.bringSubviewToFront(fromView)
        UIView.animate(withDuration: PushTransition.duration,animations:  {
            fromView.alpha = 0
            fromView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            toView.alpha = 1
        }) { (_) in
            fromView.transform = CGAffineTransform(scaleX: 1, y: 1)
            transitionContext.completeTransition(true)
            fromView.alpha = 1.0
        }
    }
    private func fromTopPush(fromView: UIView,
                             toView: UIView,
                             transitionContext: UIViewControllerContextTransitioning){
        transitionContext.containerView.addSubview(toView)
        toView.transform = CGAffineTransform(translationX: 0, y: -screenHeight)
        UIView.animate(withDuration: PushTransition.duration, animations: {
            toView.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    private func fromBottomPush(fromView: UIView,
                                toView: UIView,
                                transitionContext: UIViewControllerContextTransitioning){
        transitionContext.containerView.addSubview(toView)
        toView.transform = CGAffineTransform(translationX: 0, y: screenHeight)
        UIView.animate(withDuration: PushTransition.duration, animations: {
            toView.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    private func fromLeftPush(fromView: UIView,
                              toView: UIView,
                              transitionContext: UIViewControllerContextTransitioning){
        transitionContext.containerView.addSubview(toView)
        toView.transform = CGAffineTransform(translationX: -screenWidth, y: 0)
        UIView.animate(withDuration: PushTransition.duration, animations: {
            toView.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    private func fromRightPush(fromView: UIView,
                              toView: UIView,
                              transitionContext: UIViewControllerContextTransitioning){
        transitionContext.containerView.addSubview(toView)
        toView.transform = CGAffineTransform(translationX: screenWidth, y: 0)
        UIView.animate(withDuration: PushTransition.duration, animations: {
            toView.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }



}
