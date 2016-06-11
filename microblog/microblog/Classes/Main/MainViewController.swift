//
//  MainViewController.swift
//  microblog
//
//  Created by QHC on 6/10/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewControllers()
    
    }
    
    func addChildViewControllers() {
        
        let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)!
        let data = NSData(contentsOfFile: path)!
        
        guard let object = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) else
        {
            QHCLog("没有json数据加载")
            
            addOneChildController("HomeTableViewController", imageName: "tabbar_home", title: "主页")
            addOneChildController("DiscoverTableViewController", imageName: "tabbar_message_center", title: "发现")
            addOneChildController("MessageTableViewController", imageName: "tabbar_discover", title: "消息")
            addOneChildController("ProfileTableViewController", imageName: "tabbar_profile", title: "我")

            return
        }
        
        for dict in object as! [[String:AnyObject]] {
            addOneChildController(dict["vcName"] as! String, imageName: dict["imageName"] as! String, title: dict["title"] as! String)
        }
        
    }
    
    func addOneChildController(childController: String, imageName: String, title: String) {
        
        // 获取命名空间 CFBundleExecutable
        guard let executable = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as? String else {
            return
        }
        
        // 创建类
        let customClass: AnyClass? = NSClassFromString(executable + "." + childController)
        
        // 创建控制器
        guard let vc = customClass as? UITableViewController.Type else{
            return
        }
        
        let customVc = vc.init()
        
        customVc.tabBarItem.image = UIImage(named: imageName)
        customVc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        customVc.tabBarItem.title = title
        
        let nav = UINavigationController(rootViewController: customVc)
        addChildViewController(nav)
        
    }
    

}
