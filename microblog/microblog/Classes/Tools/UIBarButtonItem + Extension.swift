//
//  UIBarButtonItem + Extension.swift
//  microblog
//
//  Created by QHC on 6/13/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

extension UIBarButtonItem
{
    // 便利构造方法
    convenience init(imageName: String, target: AnyObject, action: Selector)
    {
        let btn = UIButton(type: UIButtonType.Custom)
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        
        self.init(customView: btn)
        
    }


}