//
//  QRResultViewController.swift
//  microblog
//
//  Created by QHC on 6/17/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

class QRResultViewController: UIViewController {

    var resultString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webV)
        
        let request = NSURLRequest(URL: NSURL(string: resultString)!)
        webV.loadRequest(request)
    }
    
    private lazy var webV: UIWebView = {
        
        let webV = UIWebView()
        webV.frame = self.view.bounds
        
        return webV
    }()
    

}
