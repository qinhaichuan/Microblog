//
//  VisitorView.swift
//  microblog
//
//  Created by QHC on 6/13/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    
    @IBOutlet weak var turntableImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textlbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    // 快速创建类方法
    class func visitorView() -> VisitorView
    {
        return NSBundle.mainBundle().loadNibNamed("VisitorView", owner: nil, options: nil).last as! VisitorView
    }
    
    
    // 外部方法
    func setupChildVisitorView(imageName: String?, title: String)
    {
        guard let iconName: String = imageName else {
            startAnimation()
            return
        }
        
        iconImageView.image = UIImage(named: iconName)
        textlbl.text = title
        turntableImageView.hidden = true
    }
    
    

    
    private func startAnimation()
    {
        let customAnima = CABasicAnimation(keyPath: "transform.rotation")
        customAnima.toValue = 2 * M_PI
        customAnima.repeatCount = MAXFLOAT
        customAnima.duration = 10.0
        
        // 不移除动画, 只有当前view销毁时才移除
        customAnima.removedOnCompletion = false
        
        turntableImageView.layer.addAnimation(customAnima, forKey: nil)
    }
    
    

}
