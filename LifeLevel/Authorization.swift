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
        
        guard let username = KeychainWrapper.standard.string(forKey: "username")  else {
            return false
        }

        loginInfo.accessToken = accessToken
        loginInfo.userId = userId
        loginInfo.username = username
            
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
    
    func registerUserConfirmed(email:String,password:String,confirmPassword:String,firstName:String,lastName:String,
                               completion: @escaping (Bool)->Void)
    {
        clSrvIntegBase.registerUserConfirmed(email: email, password: password, confirmPassword: confirmPassword,
                                             firstName: firstName, lastName: lastName)
        {response in
            switch response{
            case true:
                print("register ok!!!")
                completion(true)
            case false:
                completion(false)
            }
        }
    }

    
    func logout()
    {
        KeychainWrapper.standard.removeObject(forKey: "accessToken")
        KeychainWrapper.standard.removeObject(forKey: "refreshToken")
        KeychainWrapper.standard.removeObject(forKey: "username")
        KeychainWrapper.standard.removeObject(forKey: "userId")
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
