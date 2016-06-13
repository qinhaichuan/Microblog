//
//  ProfileTableViewController.swift
//  microblog
//
//  Created by QHC on 6/10/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

class ProfileTableViewController: CommonTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isLogin {
            visitorView?.setupChildVisitorView("visitordiscover_image_profile", title: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
        }
        
    }
}
