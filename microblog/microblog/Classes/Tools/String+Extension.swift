//
//  String+Extension.swift
//  microblog
//
//  Created by QHC on 6/18/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

extension String
{
    // 返回一个文件目录的路径
    func documentDirectory() -> String {
        let documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        let documentDirectory = (documentPath as NSString).stringByAppendingPathComponent((self as NSString).pathComponents.last!)
    
        return documentDirectory
    }
    
    // 返回一个缓存目录的路径
    func cacheDirectory() -> String {
        let cachePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        let cacheDirectory = (cachePath as NSString).stringByAppendingPathComponent((self as NSString).pathComponents.last!)
        
        return cacheDirectory
    }
    
    // 返回一个临时目录的路径
    func tmpDirectory() -> String {
        let tmptPath = NSTemporaryDirectory()
        let tmpDirectory = (tmptPath as NSString).stringByAppendingPathComponent((self as NSString).pathComponents.last!)
        
        return tmpDirectory
    }
    



}