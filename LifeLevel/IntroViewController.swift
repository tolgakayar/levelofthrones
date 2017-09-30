//
//  IntroViewController.swift
//  LifeLevel
//
//  Created by Mac on 30/08/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let auth = Authorization()
        if auth.checkState()
        {
            //navigate to main page
            print("you are in!!!")
            //auth.logout()
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let activitiesViewController = storyBoard.instantiateViewController(withIdentifier: "activitiesViewController") as! ActivitiesTableViewController
            activitiesViewController.loginInfo = auth.loginInfo
            self.present(activitiesViewController, animated: true, completion: nil)
        }
        else
        {
            //navigate to logon page
            print("you are out!!!")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = storyBoard.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
            self.present(loginViewController, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
