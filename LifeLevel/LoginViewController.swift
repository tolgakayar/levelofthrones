//
//  LoginViewController.swift
//  LifeLevel
//
//  Created by Mac on 13/08/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class LoginViewController: UIViewController, UITextFieldDelegate,LoginButtonDelegate {

    
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
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userEvents, .userLikes, .userFriends ])
        loginButton.center = view.center
        loginButton.delegate = self
        
        view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    @IBAction func loginButton(_ sender: Any) {
        
        guard let userName = usernameText.text else{
            return
        }
        
        guard let password = passwordText.text else{
            return
        }
        
        let auth = Authorization()
        auth.login(username:userName,password: password)
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
    
    //MARK: LoginButtonDelegate Delegate Functions
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .failed(let error):
            print(error)
        case .cancelled:
            print("Cancelled")
        case .success(let grantedPermissions, let declinedPermissions, let accessToken):
            print("Logged In")
            getFBUserInfo()
            {response in
                if response.0{
                    let auth = Authorization()
                    let password:String = "extFB" + accessToken.userId!
                    let username:String = password + "@facebook.com";
                    auth.registerUserConfirmed(email: response.1, password: password, confirmPassword: password, firstName: response.2, lastName: "")
                    {response in
                        auth.login(username:username,password: password)
                        {response in
                            print(auth.loginInfo.accessToken)
                            //navigate to profile page
                        }
                    }
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("Logged Out")
    }
    
    func getFBUserInfo(completion: @escaping (_ returnValue:Bool, _ emailText: String,_ nameText: String)->Void) {
        let request = GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: FacebookCore.GraphAPIVersion.defaultVersion)
        request.start { (response, result) in
            switch result {
            case .success(let value):
                var email:String=""
                var name:String=""

                var temp = value.dictionaryValue?["email"]
                if let nonNil = temp, !(nonNil is NSNull) {
                    email = String(describing: nonNil)
                }
                
                temp = value.dictionaryValue?["name"]
                if let nonNil = temp, !(nonNil is NSNull) {
                    name = String(describing: nonNil)
                }
                
                completion(true,email,name)
            case .failed(let error):
                print(error)
                completion(false,"","")
            }
        }
    }
}

