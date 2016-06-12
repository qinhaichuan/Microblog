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
    convenience init(imageName: String, backgroundImageName: String)
    {
        self.init()
    
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        setBackgroundImage(UIImage(named: backgroundImageName), forState: UIControlState.Normal)
        setBackgroundImage(UIImage(named: backgroundImageName + "_highlighted"), forState: UIControlState.Highlighted)
        
        sizeToFit()
    }


}