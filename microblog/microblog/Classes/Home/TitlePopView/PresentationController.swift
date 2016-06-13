//
//  PresentationController.swift
//  microblog
//
//  Created by QHC on 6/13/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

  /// 转场动画

class PresentationController: UIPresentationController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    // 记录当前是否展现
    private var isPresented = false
    // 菜单尺寸
    var customFrame = CGRectZero
    
  
    /**
     告诉系统谁来负责自定义转场
     
     - parameter presented:  被modal出来的控制器
     - parameter presenting: 发现modal的控制器
     */
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        let titlePresentCon = TitlePresentationController(presentedViewController: presented, presentingViewController: presenting)
        titlePresentCon.customeFrame = customFrame
        
        return titlePresentCon
    }
    
    /**
     *  告诉系统谁来负责展示自定义样式
     */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        NSNotificationCenter.defaultCenter().postNotificationName(QHCPOPVIEWCONTROLLERPRESENTCLICK, object: self)
        return self
    }
    
    /**
     *  告诉系统谁来负责消失自定义样式
     */
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        NSNotificationCenter.defaultCenter().postNotificationName(QHCPOPVIEWCONTROLLERDISMISSCLISK, object: self)
        return self
    }
    
    /**
     *  展现或消失时长
     */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    // 无论是展现还是消失都会调用这个方法
    // 我们需要在这个方法中告诉系统, 菜单如何展现
    // 注意点: 只要实现了这个方法, 那么系统就不会再管控制器如何弹出和消失了, 所有的操作都需要我们自己做
    // transitionContext: 里面就包含了所有需要的参数
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {

        if isPresented {
            
            // 添加展现
            let presentView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            transitionContext.containerView()?.addSubview(presentView)
            
            // 添加动画
            presentView.transform = CGAffineTransformMakeScale(1.0, 0)
            presentView.layer.anchorPoint = CGPointMake(0.5, 0)
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
                () -> ()
                in
                presentView.transform = CGAffineTransformIdentity
                
                }, completion: { (_) in
                    // 动画完成
                    transitionContext.completeTransition(true)
            })
 
        }else{  // 消失
            
            let dismissView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
                () -> ()
                in
                dismissView.transform = CGAffineTransformMakeScale(1.0, 0.000000001)
                }, completion: { (_) in
                        transitionContext.completeTransition(true)
            })

        }
    
    
    }
    
    
    
}
