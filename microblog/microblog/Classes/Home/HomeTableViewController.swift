//
//  HomeTableViewController.swift
//  microblog
//
//  Created by QHC on 6/10/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

class HomeTableViewController: CommonTableViewController {

    // MARK: -----  Lazy Load
    private lazy var titleBtn: TitleButton = {
        
        // 标题view
        let btn = TitleButton()
        btn.addTarget(self, action: "titleViewClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()
    
    private lazy var presentedController: PresentationController = {
        
        let presentCon = PresentationController()
        presentCon.customFrame = CGRect(x: 120, y: 50, width: 120, height: 200)
    
        return presentCon
    }()
    
    
    
    // MARK: -----  生命周期方法 
    override func viewDidLoad() {
        super.viewDidLoad()

        if !isLogin {
            visitorView?.setupChildVisitorView(nil, title: "")
        }
        
        addBarButtonItem()
        
        // 注册通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeTableViewController.titleBtnClick), name: QHCPOPVIEWCONTROLLERDISMISSCLISK, object: self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeTableViewController.titleBtnClick), name: QHCPOPVIEWCONTROLLERDISMISSCLISK, object: self)
        
    }
    
    func addBarButtonItem()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "navigationbar_friendattention", target: self, action: #selector(HomeTableViewController.leftClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(imageName: "navigationbar_pop", target: self, action: #selector(HomeTableViewController.rightClick))
        
        navigationItem.titleView = titleBtn

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
        
        popViewCon.transitioningDelegate = presentedController
        popViewCon.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        presentViewController(popViewCon, animated: true, completion: nil)
        
    }
    
    @objc private func titleBtnClick()
    {
        titleBtn.selected = !titleBtn.selected
    }
    
    
    
}
