//
//  OAuthViewController.swift
//  microblog
//
//  Created by QHC on 6/18/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {

    @IBOutlet weak var webV: UIWebView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // 加载未授权界面
        loadRequestPage()
    }
    
    private func loadRequestPage() {
        
        let requestStr = "https://api.weibo.com/oauth2/authorize?client_id=\(WB_App_Key)&redirect_uri=\(WB_Redirect_URI)"
        guard let requestUrl = NSURL(string: requestStr) else {
            return
        }
        
        webV.loadRequest(NSURLRequest(URL: requestUrl))
        
    }
   
    
    // MARK: -----  点击
    
    @IBAction func closeClick(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 自动填充
    @IBAction func fillClick(sender: UIBarButtonItem) {
        
        let js = "document.getElementById('userId').value='qin_haichuan@163.com';"
        webV.stringByEvaluatingJavaScriptFromString(js)
    
    }

    
    
    
}
