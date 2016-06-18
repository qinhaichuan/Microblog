//
//  NetRequestManager.swift
//  microblog
//
//  Created by QHC on 6/18/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit
import AFNetworking

class NetRequestManager: AFHTTPSessionManager {

    // 网络单例类
    static let shareNetRequestManager: NetRequestManager = {
        
        let url = NSURL(string: "https://api.weibo.com/")
        let instance = NetRequestManager(baseURL: url, sessionConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration())
        instance.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set<String>
        return instance
    }()
    
    
    
}
