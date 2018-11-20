//
//  AnimationTable.swift
//  Notepad
//
//  Created by juntuo on 2018/11/20.
//  Copyright © 2018 juntuo. All rights reserved.
//

import UIKit
/* UIView.animate
 * withDuration: 动画的持续时间,也可以理解为动画的执行速度,持续时间越小速度越快
 * delay: 动画开始之前的延时,默认是无延时的
 * options: 一个附加项,运动动画速度曲线,可以指定多个
 * animations: 动画执行的闭包
 * completion: 动画完成执行的闭包.,可以在这里链接下一个动画
 * usingSpringWithDamping: 弹簧阻力,数值越小,弹簧的震动效果越明显
 * initialSpringVelocity: 动画d初始的速度.数值越大初始速度越快,但要注意的是，初始速度取值较高而时间较短时，也会出现反弹情况。
 */
///////////////////////
/* CGAffineTransform
 * scaleX: 缩放
 * rotationAngle: 旋转
 * translationX: 平移
 */
////////////////////////
/* CATransform3D
 * y 轴方向放大两倍: CATransform3DMakeScale(1, 2, 1)
 * 以向量(1, 1, 1)为轴, 旋转90度: CATransform3DMakeRotation(CGFloat.pi / 2, 1, 1, 1)
 * 向x轴平移50, 向y轴平移50, 向z轴平移50: CATransform3DMakeTranslation(50, 50, 50)
 */
class AnimationTable: BaseTableView {
    enum TableViewAnimationType {
        case move
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
        case rote
        case custom
    }

    // 设置动画属性
    static private var duration: CFTimeInterval = 1.0
    static private var type: TableViewAnimationType = .layDown

    func cellAnimationWithType(type: TableViewAnimationType, duration: CFTimeInterval){
        AnimationTable.duration = duration
        switch type {
        case .move:
           moveAnimation()

        case .moveSpring:
           moveSpringAnimation()
        case .alpha:
           alphaAnimation()
        case .fallTop:
            fallTopAnimation()
        case .fallBottom:
            fallBottomAnimation()
        case .shake:
            shakeAnimation()
        case .overTurn:
           overTurnAnimation()
        case .toTop:
           toTopAnimation()
        case .springList:
            springListAnimation()
        case .shrinkToTop:
            shrinkToTopAnimation()
        case .layDown:
           layDownAnimation()
        case .rote:
            roteAnimation()
        case .custom:
            customAnimation()
        }
    }
    //从左边出现
    private func moveAnimation(){
        let totalTime = 0.3
        let delayTime = totalTime / Double(self.visibleCells.count)
        var index = 0
        for cell in self.visibleCells{
            //translationX: 沿x轴平移-screenWidth
            //delay: 动画延迟一下,有层次感
           cell.transform = CGAffineTransform(translationX: -screenWidth, y: 0)
            UIView.animate(withDuration: AnimationTable.duration, delay: Double(index) * delayTime, options: [], animations: {
                //复原动画
                cell.transform =  CGAffineTransform.identity
            }, completion: nil)
            index += 1
        }
    }
    //从左边出现
    private func moveSpringAnimation(){
        let delayTime = AnimationTable.duration / Double(self.visibleCells.count)
        var index = 0
        for cell in self.visibleCells{
            cell.transform = CGAffineTransform(translationX: -screenWidth, y: 0)
            // usingSpringWithDamping: 动画效果.取值0-1.数值越小.效果越明显
            // initialSpringVelocity: 动画初始速度,越大初始时速度越快
            UIView.animate(withDuration: AnimationTable.duration, delay: delayTime, usingSpringWithDamping: 0.7, initialSpringVelocity: 1/0.7, options: [], animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
             index += 1
        }


    }
    //一个的出现
    private func alphaAnimation(){
        let delayTime = 0.05
        var index = 0

        for cell in self.visibleCells {

            cell.alpha = 0
            UIView.animate(withDuration: AnimationTable.duration, delay: Double(index)*delayTime, options: [], animations: {
                cell.alpha = 1
            }, completion: nil)
              index += 1
        }

    }
    //从上面掉落
    private func fallTopAnimation(){

        let delayTime = AnimationTable.duration / Double(self.visibleCells.count)
        var index = 0
        for cell in self.visibleCells{

            cell.transform = CGAffineTransform(translationX: 0, y: -screenHeight)
            UIView.animate(withDuration: AnimationTable.duration, delay: Double(self.visibleCells.count-index) * delayTime, options: [], animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
             index += 1
        }

    }
    //从底部出现
        private func fallBottomAnimation(){

        let delayTime = AnimationTable.duration / Double(self.visibleCells.count)
        var index = 0
        for cell in self.visibleCells{

        cell.transform = CGAffineTransform(translationX: 0, y: screenHeight)
        UIView.animate(withDuration: AnimationTable.duration, delay: Double(index) * delayTime, options: [], animations: {
        cell.transform = CGAffineTransform.identity
        }, completion: nil)
        index += 1
        }

    }

    //一个从左边进来,一个从右边
    private func shakeAnimation(){

        let delayTime = 1.0
        var index = 0
        for cell in self.visibleCells{

            let i = index % 2 == 0 ? -screenWidth:screenWidth
            cell.transform = CGAffineTransform(translationX: i, y: 0)
            UIView.animate(withDuration: AnimationTable.duration, delay: Double(index) * delayTime, usingSpringWithDamping: 0.75, initialSpringVelocity: 1/0.75, options: [], animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
             index += 1
        }

    }
    //加了一个3d效果
    private func overTurnAnimation(){

        let delayTime = AnimationTable.duration / Double(self.visibleCells.count)
        var index = 0
        for cell in self.visibleCells{
            //opacity是一个浮点值，取值范围0~1.0,表示从完全透明到完全不透明。
            cell.layer.opacity = 0.0
            cell.layer.transform = CATransform3DMakeRotation(CGFloat(2*M_PI), 1, 0, 0)

            UIView.animate(withDuration: AnimationTable.duration, delay: Double(index) * delayTime, options: [], animations: {
                cell.layer.opacity = 1.0
            }, completion: nil)
             index += 1
        }

    }
    //从底部出现
    private func toTopAnimation(){

        let delayTime = AnimationTable.duration / Double(self.visibleCells.count)
        var index = 0
        for cell in self.visibleCells{

            cell.transform = CGAffineTransform(translationX: 0, y: screenHeight)
            UIView.animate(withDuration: AnimationTable.duration, delay: Double(index)*delayTime, options: UIView.AnimationOptions.curveEaseOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
              index += 1

        }

    }
    //从上面掉落,带3D特效
    private func springListAnimation(){
        let totalTime = 1.0
        let delayTime = totalTime / Double(self.visibleCells.count)
        var index = 0
        for cell in self.visibleCells{

            cell.layer.opacity = 0.7
            cell.layer.transform = CATransform3DMakeTranslation(0, -screenHeight, 20)
            UIView.animate(withDuration: AnimationTable.duration, delay: Double(index) * delayTime, usingSpringWithDamping: 0.65, initialSpringVelocity: 1/0.65, options: UIView.AnimationOptions.curveEaseIn, animations: {
               cell.layer.opacity = 1.0
               cell.layer.transform = CATransform3DMakeTranslation(0, 0, 20)
            }, completion: nil)
             index += 1
        }

    }
    //
    private func shrinkToTopAnimation(){

        var index = 0
        for cell in self.visibleCells{

            let rect = cell.convert(cell.bounds, from: self)
            cell.transform = CGAffineTransform(translationX: 0, y: -rect.origin.y)
            UIView.animate(withDuration: AnimationTable.duration) {
                cell.transform = CGAffineTransform.identity
            }
            index += 1
        }

    }
    //
    private func layDownAnimation(){
        var rectArr:[Any] = []
        var index = 0
        for cell in self.visibleCells{

            var rect = cell.frame
            rectArr.append(rect)
            rect.origin.y = CGFloat(index * 10)
            cell.frame = rect
            cell.layer.transform = CATransform3DMakeTranslation(0, 0, CGFloat(index * 5))

             index += 1
        }
        let totalTime = 0.4
        var index2 = 0

        for cell2 in self.visibleCells {

            let rect = rectArr[index2]
            UIView.animate(withDuration: totalTime/Double(self.visibleCells.count), animations: {
                cell2.frame = rect as! CGRect
            }) { (_) in
                cell2.layer.transform = CATransform3DIdentity
            }
             index2 += 1

        }

    }
    //
    private func roteAnimation(){
        let animation = Animation.baseAnimationWithKeyPath("transform.rotation.y", fromValue: -M_PI, toValue: 0, duration: 0.3, repeatCount: 3, timingFunction: nil)
        var index = 0
        for cell in self.visibleCells{

            cell.alpha = 0
            UIView.animate(withDuration: 0.4, delay: Double(index)*0.25, options: [], animations: {
                cell.alpha = 1
            }) { (_) in
                cell.layer.add(animation, forKey: "rotationYkey")
            }
            index += 1

        }
    }
    private func customAnimation(){
        let degrees = sin(90.0 * CGFloat.pi/180.0)
        let rotationTransform = CGAffineTransform(rotationAngle: degrees)
         let flipTransform = CGAffineTransform(scaleX: -1, y: -1)
        let customTransform = rotationTransform.concatenating(flipTransform)
        var index = 0
        for cell in self.visibleCells{

            cell.layer.setAffineTransform(customTransform)
            UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.0, options: [], animations: {
                cell.layer.setAffineTransform(.identity)
            }, completion: nil)
            index += 1

        }

    }

}
