//
//  ViewController.swift
//  LifeLevel
//
//  Created by Mac on 13/08/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        let auth = Authorization()
        var result = auth.login(username:"tolgakayar@yahoo.com",password: "Goligo123;")
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

