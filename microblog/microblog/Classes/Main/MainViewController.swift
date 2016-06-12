//
//  MainViewController.swift
//  microblog
//
//  Created by QHC on 6/10/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    // MARK: -----  懒加载
    private lazy var customBtn: UIButton = {
        
        let btn = UIButton(imageName: "tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
        btn.addTarget(self, action: #selector(MainViewController.customBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()
    
    // MARK: -----  生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()

//        addChildViewControllers()
    
    }
    
    // storyboard方式添加button
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBar.addSubview(customBtn)
        let width = tabBar.bounds.width / CGFloat(childViewControllers.count)
        let height = customBtn.bounds.height
        let btnRect = CGRectMake(0, 0, width, height)
        customBtn.frame = CGRectOffset(btnRect, 2 * width, 0)
    }
    
    // MARK: -----  添加子控件(代码方式)
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
    
    // MARK: -----  加号按钮点击
    @objc private func customBtnClick() {
    
        QHCLog("点击了加号按钮")
    }
    

}
