//
//  DiscoverTableViewController.swift
//  microblog
//
//  Created by QHC on 6/10/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

class DiscoverTableViewController: CommonTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isLogin {
            visitorView?.setupChildVisitorView("visitordiscover_image_message", title: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
        }
    }
}
