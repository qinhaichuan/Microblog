//
//  UserAccount.swift
//  microblog
//
//  Created by QHC on 6/18/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

class UserAccount: NSObject, NSCoding {

    /// 用于调用access_token，接口获取授权后的access token。
    var access_token: String?
    /// access_token的生命周期，单位是秒数。
    var expires_in: NSNumber?
    /// 当前授权用户的UID。
    var uid: String?
    
    static var userAccount: UserAccount?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override var description: String {
        
        let proterty = ["access_token", "expires_in", "uid"]
        let dict = dictionaryWithValuesForKeys(proterty)
    
        return "\(dict)"
    }
    
    // MARK: -----  保存模型到文件中
    
    static let filePath = "userAccount.plsit".cacheDirectory()
    /**
     *  保存模型
     */
    func saveAccount() {
        NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.filePath)
    }
    
    /**
     *  取出模型
     */
    class func getUserAccount() -> UserAccount {
    
        if userAccount != nil {
            return userAccount!
        }
        
        // 如果没有就取出
        userAccount = NSKeyedUnarchiver.unarchiveObjectWithFile(UserAccount.filePath) as? UserAccount
        
        return userAccount!
    }
    
    
    // MARK: -----  NSCoding
    
    /**
     *  归档
     */
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
    }
    
    /**
     *  解档
     */
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        uid = aDecoder.decodeObjectForKey("uid") as? String
    }
    
    
    
    
    
    
    
    
}
