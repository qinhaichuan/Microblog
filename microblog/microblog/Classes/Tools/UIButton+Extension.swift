//
//  UIButton+Extension.swift
//  microblog
//
//  Created by QHC on 6/12/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

extension UIButton
{
    // 便利构造方法只调用一次当前类的构造方法就可以了
    convenience init(imageName: String, backgroundImageName: String)
    {
        self.init(backgroundImageName: backgroundImageName)
    
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        
        sizeToFit()
    }

    convenience init(backgroundImageName: String)
    {
        // 这里已经调用, 上面方法中就不需要再调用
        self.init()
        
        setBackgroundImage(UIImage(named: backgroundImageName), forState: UIControlState.Normal)
        setBackgroundImage(UIImage(named: backgroundImageName + "_highlighted"), forState: UIControlState.Highlighted)
    
        sizeToFit()
    }

}