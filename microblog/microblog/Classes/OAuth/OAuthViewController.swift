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
      
        webV.delegate = self

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

// MARK: -----  UIWebViewDelegate
extension OAuthViewController: UIWebViewDelegate {
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        QHCLog(request.URL!)
        
        // 判断是否是授权回调地址, 如果不是, 就继续跳转
        guard let urlString = request.URL?.absoluteString where urlString.hasPrefix(WB_Redirect_URI) else {
            return true
        }
        
        // 判断是否授权成功, 如果失败就不跳转
        let code = "code="
        guard urlString.containsString(code) else {
            return false
        }
        
        // 如果授权成功, 继续跳转
        if let temp = request.URL?.query {
            let codeString = temp.substringFromIndex(code.endIndex)
            QHCLog(codeString)
            // 获取assoceToken
            getAccessToken(codeString)
        }
        
        
        return false
    }

    private func getAccessToken(codeStr: String) {
        
        let path = "oauth2/access_token"
        let parameters = ["client_id": WB_App_Key,
                          "client_secret": WB_App_Secret,
                          "grant_type": "authorization_code",
                          "code": codeStr,
                          "redirect_uri": WB_Redirect_URI
                          ]
        
        NetRequestManager.shareNetRequestManager.POST(path, parameters: parameters, progress: { (progress) in
            
            }, success: { (task, object) in
                
                print("------请求成功", object)
                
                // 保存模型
                let userAccount = UserAccount(dict: (object as! [String: AnyObject]))
                userAccount.saveAccount()
                
            }) { (task, error) in
                print("------请求失败", error)
                
        }
        
        
    
    }
    
    
    

}



