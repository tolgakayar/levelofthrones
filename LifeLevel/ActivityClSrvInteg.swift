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
    func getUserActivities(userId:String,mainUserId:String,fromActivityId:Int, completion: @escaping ([Activity])->Void)
    {
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        
        print("token: \(accessToken)")
        
        let url = targetUrl + "/api/useractivities/getuseractivities/" + userId + "/" + mainUserId + "/" + String(fromActivityId)
        
        Alamofire.request(url, method: .get, headers: headers)
            .responseJSON { response in

                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    var activities = [Activity]()
                    for subJson in json.arrayValue {
                        let activityType = subJson["activityType"].string
                        let likeCount = subJson["TotalLikeCount"].int
                        let description = subJson["userActivities"]["Description"].string
                        let mainPhoto = subJson["userActivities"]["MainPhoto"].string
                        let activityId = subJson["userActivities"]["ActivityId"].int
                        let id = subJson["userActivities"]["Id"].int
                        let activityDate = subJson["userActivities"]["ActivityDate"].string

                        //var tempPhoto = "test-image.jpeg"
                        var tempPhoto = ""
                        if mainPhoto != nil{
                            tempPhoto = mainPhoto!
                        }
                        
                        let activity = Activity(username: "", description: description!, activity: activityType!, mainPhoto: tempPhoto, date: activityDate!, id: id!, activityId: activityId!, totalLikeCount: likeCount!)
                        
                        activities.append(activity!)
                    }
                    
                    completion(activities)
                case .failure(let error):
                    print("error:   \(error)")
                    let activities = [Activity]()
                    completion(activities)
                }
        }
    }
}
