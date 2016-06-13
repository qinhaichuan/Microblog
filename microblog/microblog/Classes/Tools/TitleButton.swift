//
//  TitleButton.swift
//  microblog
//
//  Created by QHC on 6/13/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    // 代码创建时加载
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 防止高亮变色
        adjustsImageWhenHighlighted = false
       
        setTitle("我的微博 ", forState: UIControlState.Normal)
        setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
        sizeToFit()
        
    }
    
    // xib/sb创建时加载
    // 重写 override init(frame: CGRect) 方法时, 必须要重写此方法, 系统会提示
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 调换文字和图片的位置
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = CGRectGetMaxX((titleLabel?.frame)!)
        
    }
    

}
