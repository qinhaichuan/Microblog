//
//  MessageTableViewController.swift
//  microblog
//
//  Created by QHC on 6/10/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

class MessageTableViewController: CommonTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !isLogin {
            visitorView?.setupChildVisitorView("visitordiscover_image_message", title: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
        }
        
    }
}
