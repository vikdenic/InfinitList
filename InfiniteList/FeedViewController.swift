//
//  FeedViewController.swift
//  InfiniteList
//
//  Created by Vik Denic on 2/8/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

  var backendless = Backendless.sharedInstance()

  override func viewDidLoad() {
    super.viewDidLoad()
    checkForCurrentUser()
  }

  func checkForCurrentUser() {
    if backendless.userService.currentUser == nil {
      print("No current user")
      performSegueWithIdentifier("feedToLoginSegue", sender: self)
    } else {
      print("Current user is: \(Backendless().userService.currentUser)")
    }
  }
}
