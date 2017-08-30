//
//  LoginViewController.swift
//  LifeLevel
//
//  Created by Mac on 13/08/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Handle the text field’s user input through delegate callbacks.
        usernameText.delegate = self
        passwordText.delegate = self
        
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    @IBAction func loginButton(_ sender: Any) {
        let auth = Authorization()
        auth.login(username:"tolgakayar@yahoo.com",password: "Goligo123;")
        {response in
            print(auth.loginInfo.accessToken)
            //navigate to profile page
        }
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let tempUsernameText = usernameText.text ?? ""
        let tempPasswordText = passwordText.text ?? ""
        loginButton.isEnabled = !tempUsernameText.isEmpty && !tempPasswordText.isEmpty
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        loginButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
}

