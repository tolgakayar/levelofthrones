//
//  ActivityClSrvInteg.swift
//  LifeLevel
//
//  Created by Mac on 30/09/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import Alamofire
import SwiftyJSON

class ActivityClSrvInteg : ClSrvIntegBase
{
    func getUserActivities(userId:String,mainUserId:String,fromActivityId:Int, completion: @escaping (LoginInfo)->Void)
    {
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + accessToken
        ]
        
        let url = targetUrl + "/api/useractivities/getuseractivities" + userId + "/" + mainUserId + "/" + String(fromActivityId)
        
        Alamofire.request(url, method: .get, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    var loginInfo = LoginInfo()
                    completion(loginInfo)
                case .failure(let error):
                    print(error)
                    let loginInfo = LoginInfo()
                    completion(loginInfo)
                }
        }
    }
}
