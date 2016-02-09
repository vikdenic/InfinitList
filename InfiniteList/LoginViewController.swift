//
//  ViewController.swift
//  InfiniteList
//
//  Created by Vik Denic on 2/7/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  var backendless = Backendless.sharedInstance()

  @IBOutlet var usernameTextfield: UITextField!
  @IBOutlet var passwordTextfield: UITextField!

  override func viewDidLoad() {
      super.viewDidLoad()
  }

  func registerUser() {
    let user = BackendlessUser()
    user.email = usernameTextfield.text
    user.password = passwordTextfield.text

    backendless.userService.registering(user,
      response: { (registeredUser) -> Void in
        print("User has been registered: \(registeredUser)")
        self.dismissViewControllerAnimated(true, completion: nil)
      }) { (fault) -> Void in
        print("Server reported an error: \(fault)")
    }
  }

  func loginUser() {
    backendless.userService.login(usernameTextfield.text, password: passwordTextfield.text, response: { (loggedInUser) -> Void in
        print("User has been logged in: \(loggedInUser)")
        self.dismissViewControllerAnimated(true, completion: nil)
      }) { (fault) -> Void in
        print("Server reported an error: \(fault)")
    }
  }

  @IBAction func onSignUpTapped(sender: AnyObject) {
    registerUser()
  }

  @IBAction func onLoginTapped(sender: AnyObject) {
    loginUser()
  }
}