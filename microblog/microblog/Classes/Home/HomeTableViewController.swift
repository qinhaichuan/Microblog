//
//  HomeTableViewController.swift
//  microblog
//
//  Created by QHC on 6/10/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

class HomeTableViewController: CommonTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if !isLogin {
            visitorView?.setupChildVisitorView(nil, title: "")
        }
        
        
    }
}
