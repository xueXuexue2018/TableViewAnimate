//
//  Animation.swift
//  swiftAnimation
//
//  Created by juntuo on 2018/11/12.
//  Copyright © 2018 juntuo. All rights reserved.
//

import UIKit

class Animation: NSObject {
    class func baseAnimationWithKeyPath(_ path: String, fromValue: Any?, toValue: Any?, duration: CFTimeInterval, repeatCount: Float?, timingFunction: String?)-> CABasicAnimation {

        let animate = CABasicAnimation(keyPath: path)
        //起始值,nil表示当前值
        animate.fromValue = fromValue;
        //最终值,nil表示不改变
        animate.toValue = toValue
        //fromValue到toValue 分成0.0~1.0 ,byValue就是从0.x开始,
        //比如 旋转360°,如果该值设置成为0.5,那么动画就是从180°开始
//        animate.byValue = 0.5
        //动画结束是否停留在动画结束的位置
//        animate.isRemovedOnCompletion = false
        //动画时长
        animate.duration = duration
        // 重复次数
        animate.repeatCount = repeatCount ?? 0
        //设置该动画在该段时间内重复
//        animate.repeatDuration = 5
        //延时动画开始时间,使用CACurrentMediaTime() + 秒(s)
//        animate.beginTime = CACurrentMediaTime() + 2;
        //设置动画的速度变化
        /*
         kCAMediaTimingFunctionLinear: String        匀速
         kCAMediaTimingFunctionEaseIn: String        先慢后快
         kCAMediaTimingFunctionEaseOut: String       先快后慢
         kCAMediaTimingFunctionEaseInEaseOut: String 两头慢，中间快
         kCAMediaTimingFunctionDefault: String       默认效果和上面一个效果极为类似，不易区分
         */

        animate.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: timingFunction ?? CAMediaTimingFunctionName.easeInEaseOut.rawValue))

        //动画在开始和结束的时候的动作
        /*
         kCAFillModeForwards    保持在最后一帧，如果想保持在最后一帧，那么isRemovedOnCompletion应该设置为false
         kCAFillModeBackwards   将会立即执行第一帧，无论是否设置了beginTime属性
         kCAFillModeBoth        该值是上面两者的组合状态
         kCAFillModeRemoved     默认状态，会恢复原状
         */
        animate.fillMode = CAMediaTimingFillMode.both
        //动画结束时，是否执行逆向动画
        //        animate.autoreverses = true
        return animate
    }

    class func keyFrameAnimationWithKeyPath(_ keyPath: String, values: [Any]?, keyTimes: [NSNumber]?, path: CGPath?, duration:CFTimeInterval, cacluationMode: String, rotationMode: String?)-> CAKeyframeAnimation{

        let keyFrame = CAKeyframeAnimation(keyPath: keyPath)
        // 由关键帧,通过关键帧对应的值执行的f动画
        keyFrame.values = values
        //当设置了path之后,values 就没有效果了
        keyFrame.path = path
        //计算模式
        /*
         `discrete', 离散的，不进行插值运算
         `linear',   线性插值
         `paced',    节奏动画，自动计算动画的运动时间，是的动画均匀运行，而不是根据keyTimes的值进行动画，设置这个模式keyTimes和timingFunctions无效
         `cubic'      对关键帧为坐标点的关键帧进行圆滑曲线相连后插值计算，需要设置timingFunctions。还可以通过tensionValues，continueityValues，biasValues来进行调整自定义
         `cubicPaced' 结合了paced和cubic动画效果
         */
        keyFrame.calculationMode = CAAnimationCalculationMode(rawValue: cacluationMode)
        //旋转模式
        /*
         `auto' = kCAAnimationRotateAuto                根据路径自动旋转
         `autoReverse' = kCAAnimationRotateAutoReverse  根据路径自动翻转
         */
        keyFrame.rotationMode = rotationMode.map { CAAnimationRotationMode(rawValue: $0) }
        /*
         用来区分动画的分割时机。值区间为0.0 ~ 1.0 ，数组中的后一个值比前一个大或者相等，最好的是和Values或者Path控制的值对应
         这个属性只在 calculationMode = linear/discrete/cubic是被使用
         */
        keyFrame.keyTimes = keyTimes
        //动画时长
        keyFrame.duration = duration

        return keyFrame
    }
    class func springAnimationWithPath(_ path: String, mass: CGFloat, stiffness: CGFloat, damping: CGFloat, fromValue: Any?, toValue: Any)->CASpringAnimation{
        let springAnimate = CASpringAnimation(keyPath: path)
        //质量 影响图层运动时的弹簧惯性,质量越大,弹簧的拉伸和压缩的幅度越大,动画的速度变慢,且f波动幅度变大
        springAnimate.mass = mass
        //刚度: 越大动画越快
        springAnimate.stiffness = stiffness
        //阻尼:越大停止越快
        springAnimate.damping = damping
        //初始速率
        springAnimate.initialVelocity = 0
        //初始值
        springAnimate.fromValue = fromValue
        //结束值
        springAnimate.toValue = toValue
        print("动画停止预估时间"+"\(springAnimate.settlingDuration)")
        springAnimate.duration = springAnimate.settlingDuration

        return springAnimate
    }
    class func transitionAnimationWith(duration: CFTimeInterval, type: String, subtype: String?, startProgress: Float, endProgress: Float)->CATransition{

        let transitionAnimate = CATransition()
        //转场类型
        transitionAnimate.type = CATransitionType(rawValue: type)
        /*
         kCATransitionFromTop       从顶部转场
         kCATransitionFromBottom    从底部转场
         kCATransitionFromLeft      从左边转场
         kCATransitionFromRight     从右边转场
         */
        transitionAnimate.subtype = CATransitionSubtype(rawValue: subtype ?? "fromLeft")
        //动画开始的进度
        transitionAnimate.startProgress = startProgress
        //动画结束的进度
        transitionAnimate.endProgress = endProgress
        //g动画时间
        transitionAnimate.duration = duration

        return transitionAnimate

    }
}
