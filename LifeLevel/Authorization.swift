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
    
    func login(username:String,password:String)->Bool
    {
        clSrvIntegBase.loginUser(username:username,password:password)
        return true
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
    
    init()
    {
        userId = ""
        accessToken = ""
        refreshToken = ""
        username = ""
        firstName = ""
        lastName = ""
        lastLoginDate = ""
    }
}
