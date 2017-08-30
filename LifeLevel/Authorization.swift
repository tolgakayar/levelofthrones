//
//  Authorization.swift
//  LifeLevel
//
//  Created by Mac on 23/08/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

class Authorization
{
    var loginInfo:LoginInfo
    var clSrvIntegBase:AuthClSrvInteg
    
    init()
    {
        self.clSrvIntegBase = AuthClSrvInteg()
        self.loginInfo = LoginInfo()
    }
    
    func checkState()->Bool
    {
        guard let accessToken = KeychainWrapper.standard.string(forKey: "accessToken") else {
            return false
        }
        
        guard let userId = KeychainWrapper.standard.string(forKey: "userId") else {
            return false
        }

        loginInfo.accessToken = accessToken
        loginInfo.userId = userId
            
        return true
    }
    
    func login(username:String,password:String, completion: @escaping (Bool)->Void)
    {
        clSrvIntegBase.loginUser(username:username,password:password)
        {response in

            self.loginInfo = response
            
            //Save to Keychain
            guard KeychainWrapper.standard.set(self.loginInfo.accessToken, forKey: "accessToken") else {
                return completion(false)
            }
            
            guard KeychainWrapper.standard.set(self.loginInfo.refreshToken, forKey: "refreshToken") else {
                return completion(false)
            }
            
            guard KeychainWrapper.standard.set(self.loginInfo.username, forKey: "username") else {
                return completion(false)
            }
            
            guard KeychainWrapper.standard.set(self.loginInfo.userId, forKey: "userId") else {
                return completion(false)
            }
            
            //print(response)
            completion(true)
        }
    }
}

struct LoginInfo {
    var userId:String
    var accessToken:String
    var refreshToken:String
    var username:String
    var firstName:String
    var lastName:String
    var lastLoginDate:String
    var expireDate:String
    
    init()
    {
        userId = ""
        accessToken = ""
        refreshToken = ""
        username = ""
        firstName = ""
        lastName = ""
        lastLoginDate = ""
        expireDate = ""
    }
}
