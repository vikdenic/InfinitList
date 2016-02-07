//
//  ViewController.swift
//  InfiniteList
//
//  Created by Vik Denic on 2/7/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var backendless = Backendless.sharedInstance()

  override func viewDidLoad() {
      super.viewDidLoad()
      createNewUser()
  }

  func createNewUser() {
      let user: BackendlessUser = BackendlessUser()
      user.email = "vik.denic@gmail.com"
      user.password = "password"
      backendless.userService.registering(user)
  }
}

