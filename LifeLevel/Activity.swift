//
//  Activity.swift
//  LifeLevel
//
//  Created by Mac on 14/10/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

class Activity {
    
    //MARK: Properties
    
    var username: String
    var description: String
    var activity:String
    var mainPhoto: String
    var date: String
    var id:Int
    var activityId:Int
    var totalLikeCount:Int
    
    init?(username: String, description: String, activity: String, mainPhoto:String, date:String, id:Int,activityId:Int,totalLikeCount:Int) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        if username.isEmpty || activity.isEmpty || id < 0  {
            return nil
        }
        
        // Initialize stored properties.
        self.username = username
        self.description = description
        self.activity = activity
        self.mainPhoto = mainPhoto
        self.date = date
        self.id = id
        self.activityId = activityId
        self.totalLikeCount = totalLikeCount
    }
}
