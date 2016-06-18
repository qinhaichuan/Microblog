//
//  CommonTableViewController.swift
//  microblog
//
//  Created by QHC on 6/13/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

class CommonTableViewController: UITableViewController {
    
    // 如果已经登录就显示登录后页面
    var isLogin: Bool = false
    var visitorView: VisitorView?

    override func loadView() {
        super.loadView()
        
        isLogin ? super.loadView() : setupVisitorView()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: -----  add subviews
    func setupVisitorView() {
        
        visitorView = VisitorView.visitorView()
        view = visitorView
        
        visitorView?.loginBtn.addTarget(self, action: #selector(CommonTableViewController.loginClick), forControlEvents: UIControlEvents.TouchUpInside)
        visitorView?.registerBtn.addTarget(self, action: #selector(CommonTableViewController.registerClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CommonTableViewController.loginClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CommonTableViewController.registerClick))
        
    }


    // MARK: -----  点击
    @objc private func loginClick()
    {
        let OAuthSb = UIStoryboard(name: "OAuthViewController", bundle: nil)
        let OAuthVc = OAuthSb.instantiateInitialViewController()!
        presentViewController(OAuthVc, animated: true, completion: nil)
        
    }
    
    @objc private func registerClick()
    {
        QHCLog("注册")
    }

    


    
    
}
