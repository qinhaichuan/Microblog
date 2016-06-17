//
//  QRCodeViewController.swift
//  microblog
//
//  Created by QHC on 6/17/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {

    @IBOutlet var customContainView: UIView!
    @IBOutlet weak var customTabBar: UITabBar!
    @IBOutlet weak var scanView: UIImageView!
    @IBOutlet weak var customViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scanViewTopLayout: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customTabBar.selectedItem = customTabBar.items![0]
        customTabBar.delegate = self
        
        startAnimaton()
        
    }
    
    private func startAnimaton() {
    
        scanViewTopLayout.constant = -customViewHeight.constant
        view.layoutIfNeeded()
        
        UIView.animateWithDuration(1.0) { () -> Void in
            
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanViewTopLayout.constant = self.customViewHeight.constant
            self.view.layoutIfNeeded()
            
        }
    
    }
    
    // MARK: -----  点击
    @IBAction func closeClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    

}

extension QRCodeViewController: UITabBarDelegate {

    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
       
        customViewHeight.constant = item.tag == 0 ? 300 : 150
        
        scanView.layer.removeAllAnimations()
        startAnimaton()
        
    }

}