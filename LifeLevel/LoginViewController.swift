//
//  LoginViewController.swift
//  LifeLevel
//
//  Created by Mac on 13/08/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        let auth = Authorization()
        auth.login(username:"tolgakayar@yahoo.com",password: "Goligo123;")
        {response in
            print(auth.loginInfo.accessToken)
            //navigate to profile page
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

