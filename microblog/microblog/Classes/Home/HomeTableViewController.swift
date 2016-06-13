//
//  HomeTableViewController.swift
//  microblog
//
//  Created by QHC on 6/10/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

// 添加分类, 重写model方法
extension HomeTableViewController: UIViewControllerTransitioningDelegate
{
    /**
     告诉系统谁来负责自定义转场
     
     - parameter presented:  被model出来的控制器
     - parameter presenting: 发现model的控制器
     */
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return TitlePresentationController(presentedViewController: presented, presentingViewController: presenting)
    }

}

// MARK: -----

class HomeTableViewController: CommonTableViewController {

    // MARK: -----  生命周期方法 
    override func viewDidLoad() {
        super.viewDidLoad()

        if !isLogin {
            visitorView?.setupChildVisitorView(nil, title: "")
        }
        
        addBarButtonItem()
        
        
    }
    
    func addBarButtonItem()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "navigationbar_friendattention", target: self, action: #selector(HomeTableViewController.leftClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(imageName: "navigationbar_pop", target: self, action: #selector(HomeTableViewController.rightClick))
    
        // 标题view
        let btn = TitleButton()
        btn.addTarget(self, action: "titleViewClick:", forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.titleView = btn
    }

    
    // MARK: -----  点击方法
    @objc private func leftClick()
    {
        QHCLog("leftclick")
    }
    
    @objc private func rightClick()
    {
        QHCLog("rightclick")
    
    }
    
    @objc private func titleViewClick(titleBtn: UIButton)
    {
        titleBtn.selected = !titleBtn.selected
        
        // 设置转场
        let storyBoard = UIStoryboard(name: "PopViewController", bundle: nil)
        let popViewCon = storyBoard.instantiateInitialViewController()!
        
        popViewCon.transitioningDelegate = self
        popViewCon.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        presentViewController(popViewCon, animated: true, completion: nil)
        
    }
    
    
}
