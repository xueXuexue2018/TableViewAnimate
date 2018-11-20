//
//  AnimationType.swift
//  Notepad
//
//  Created by juntuo on 2018/11/19.
//  Copyright © 2018 juntuo. All rights reserved.
//

import UIKit
class PresentTransition: NSObject {
    enum Animate {
        case scale
        case fromLeft
        case fromRight
        case fromTop
        case fromBottom
    }
    enum Transition {
        case present
        case dismiss
    }
    //设置转场代理
    static private let transiotion = PresentTransition()
    static private var duration = 1.0
    static private var type: Animate = .scale
    static private var tran: Transition = .present
    static func presentWithAnimate(fromVC: UIViewController, toVC: UIViewController, duration: Double = 1.0, animate: Animate = .scale){
        PresentTransition.duration = duration
        PresentTransition.type = animate
        toVC.transitioningDelegate = PresentTransition.transiotion as UIViewControllerTransitioningDelegate
        fromVC.present(toVC, animated: true, completion: nil)

    }
}
extension PresentTransition:UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return PresentTransition.duration
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch PresentTransition.tran {
        case .present:
            presentTransition(transitionContext: transitionContext)
        case .dismiss:
           dismissTransition(transitionContext: transitionContext)

        }
    }
}
extension PresentTransition: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        PresentTransition.tran = .present
        return PresentTransition()
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        PresentTransition.tran = .dismiss
        return PresentTransition()
    }
}
extension PresentTransition{
    private func presentTransition(transitionContext: UIViewControllerContextTransitioning){
        let toVC = transitionContext.view(forKey: .to)
        let fromVC = transitionContext.view(forKey: .from)
        guard let toView = toVC, let fromView = fromVC else {
            return
        }
        transitionContext.containerView.addSubview(toView)
        switch PresentTransition.type {
        case .scale:
           scalePresent(fromView: fromView, toView: toView, transitionContext: transitionContext)
        case .fromLeft:
            fromLeftPresent(fromView: fromView, toView: toView, transitionContext: transitionContext)
        case .fromRight:
           fromRightPresent(fromView: fromView, toView: toView, transitionContext: transitionContext)

        case .fromTop:
            fromTopPresent(fromView: fromView, toView: toView, transitionContext: transitionContext)
        case .fromBottom:
            fromBottomPresent(fromView: fromView, toView: toView, transitionContext: transitionContext)
        }

    }

    //
    private func dismissTransition(transitionContext: UIViewControllerContextTransitioning){
        let toVC = transitionContext.view(forKey: .to)
        let fromVC = transitionContext.view(forKey: .from)
        guard let toView = toVC, let fromView = fromVC else {
            return
        }

        switch PresentTransition.type {
        case .scale:
           scaleDismiss(fromView: fromView, toView: toView, transitionContenxt: transitionContext)

        case .fromLeft:
            fromLeftDismiss(fromView: fromView, toView: toView, transitionContext: transitionContext)
        case .fromRight:
           fromRightDismiss(fromView: fromView, toView: toView, transitionContext: transitionContext)
        case .fromTop:
            fromTopDismiss(fromView: fromView, toView: toView, transitionContext: transitionContext)
        case .fromBottom:
            fromBottomDismiss(fromView: fromView, toView: toView, transitionContext: transitionContext)
        }

    }

    //
    private func scalePresent(fromView: UIView,toView: UIView, transitionContext: UIViewControllerContextTransitioning){
        toView.alpha = 0
        toView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        UIView.animate(withDuration: PresentTransition.duration,animations:  {
            toView.alpha = 1
            toView.transform = CGAffineTransform(scaleX: 1, y: 1)
            toView.frame = fromView.frame
        }) { (_) in

            transitionContext.completeTransition(true)
        }
    }
    //
    private func scaleDismiss(fromView: UIView, toView: UIView, transitionContenxt: UIViewControllerContextTransitioning){
        transitionContenxt.containerView.insertSubview(toView, belowSubview: fromView)
        UIView.animate(withDuration: PresentTransition.duration, animations: {
            fromView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }) { (_) in
            transitionContenxt.completeTransition(true)
        }
    }
    //
    private func fromLeftPresent(fromView: UIView, toView: UIView, transitionContext: UIViewControllerContextTransitioning){
        toView.frame = CGRect(x: -screenWidth, y: 0, width: screenWidth, height: screenHeight)
        UIView.animate(withDuration: PresentTransition.duration, animations: {
            toView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
            toView.layoutSubviews()
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    //
    private func fromLeftDismiss(fromView: UIView, toView: UIView, transitionContext: UIViewControllerContextTransitioning){
        transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
        UIView.animate(withDuration: PresentTransition.duration, animations: {
            fromView.transform = CGAffineTransform(translationX: 0, y: screenHeight)
            fromView.alpha = 0
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    //
    private func fromRightPresent(fromView: UIView, toView: UIView, transitionContext: UIViewControllerContextTransitioning){
        toView.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
        UIView.animate(withDuration: PresentTransition.duration, animations: {
            toView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
            toView.layoutSubviews()
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    //
    private func fromRightDismiss(fromView: UIView, toView: UIView,transitionContext: UIViewControllerContextTransitioning){
        transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
        UIView.animate(withDuration: PresentTransition.duration, animations: {
            fromView.transform = CGAffineTransform(translationX: 0, y: screenHeight)
            fromView.alpha = 0
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    //
    private func fromTopPresent(fromView: UIView, toView: UIView,transitionContext: UIViewControllerContextTransitioning){
        toView.frame = CGRect(x: 0, y: -screenHeight, width: screenWidth, height: screenHeight)
        UIView.animate(withDuration: PresentTransition.duration, animations: {
            toView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
            toView.layoutSubviews()
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    //
    private func fromTopDismiss(fromView: UIView, toView: UIView, transitionContext: UIViewControllerContextTransitioning){
        transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
        UIView.animate(withDuration: PresentTransition.duration, animations: {
            fromView.transform = CGAffineTransform(translationX: 0, y: screenHeight)
            fromView.alpha = 0
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    //
    private func fromBottomPresent(fromView: UIView, toView: UIView,transitionContext: UIViewControllerContextTransitioning){
        toView.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: screenHeight)
        UIView.animate(withDuration: PresentTransition.duration, animations: {
            toView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
            toView.layoutSubviews()
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    //
    private func fromBottomDismiss(fromView: UIView, toView: UIView, transitionContext: UIViewControllerContextTransitioning){
        transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
        UIView.animate(withDuration: PresentTransition.duration, animations: {
            fromView.transform = CGAffineTransform(translationX: 0, y: screenHeight)
            fromView.alpha = 0
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
}
