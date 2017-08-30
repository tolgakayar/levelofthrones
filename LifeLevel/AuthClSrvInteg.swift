//
//  AuthClSrvInteg.swift
//  LifeLevel
//
//  Created by Mac on 23/08/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import Alamofire
import SwiftyJSON

class AuthClSrvInteg : ClSrvIntegBase
{
    func loginUser(username:String,password:String, completion: @escaping (LoginInfo)->Void)
    {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters = [
            "grant_type": "password",
            "username": username,
            "password": password
        ]
        
        let url = secureTargetUrl + "/Token"

        Alamofire.request(url, method: .post, parameters: parameters,headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    var loginInfo = LoginInfo()
                    loginInfo.accessToken = json["access_token"].stringValue
                    loginInfo.refreshToken = json["refresh_token"].stringValue
                    loginInfo.username = json["userName"].stringValue
                    loginInfo.userId = json["userId"].stringValue
                    completion(loginInfo)
                    //print("JSON: \(json)")
                case .failure(let error):
                    print(error)
                    let loginInfo = LoginInfo()
                    completion(loginInfo)
                }
        }
    }
}
