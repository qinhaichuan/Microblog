//
//  TitlePresentationController.swift
//  microblog
//
//  Created by QHC on 6/13/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

 /// 设置展现view

class TitlePresentationController: UIPresentationController {

    var customeFrame = CGRectZero
    
    private lazy var maskView: UIView = {
        
        let maskV = UIView()
        maskV.backgroundColor = UIColor(white: 0.7, alpha: 0.5)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TitlePresentationController.dismissClick))
        maskV.addGestureRecognizer(tapGesture)
        
        return maskV
    }()
    
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        // containerView 容器视图 (所有被展现的内容都再容器视图上)
        // presentedView() 被展现的视图(当前就是弹出菜单控制器的view)
        
        // 添加蒙板, 监听点击事件
        containerView?.insertSubview(maskView, atIndex: 0)
        maskView.frame = containerView!.bounds
        
        presentedView()?.frame = customeFrame 
        
        
    }
    
    @objc private func dismissClick()
    {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil
        )
    }
    
    
}
