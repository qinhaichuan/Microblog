//
//  WelcomeViewController.swift
//  microblog
//
//  Created by QHC on 6/25/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    /// 头像
    @IBOutlet weak var iconImageV: UIImageView!
    /// 欢迎Label
    @IBOutlet weak var welcomeLbl: UILabel!
    /// 头像底部约束
    @IBOutlet weak var iconViewLayout: NSLayoutConstraint!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setupAnimation()
    }

    private func setupAnimation() {
    
        let iconImageOffset = view.bounds.size.height - iconViewLayout.constant
        iconViewLayout.constant = iconImageOffset
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.view.layoutIfNeeded()
            }) { (_) -> Void in
                self.welcomeLbl.alpha = 1.0
        }
        
        
        
    }
    
}
