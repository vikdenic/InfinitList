//
//  AppDelegate.swift
//  InfiniteList
//
//  Created by Vik Denic on 2/7/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  let APP_ID = "5BF94B17-2E10-D0C9-FF48-786984C63C00"
  let SECRET_KEY = "ADCDAFE4-468B-C8AE-FFB3-C3BC642BAD00"
  let VERSION_NUM = "v1"

  var backendless = Backendless.sharedInstance()

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    backendless.initApp(APP_ID, secret:SECRET_KEY, version:VERSION_NUM)
    backendless.userService.setStayLoggedIn(true)
    
    // If you plan to use Backendless Media Service, uncomment the following line (iOS ONLY!)
    // backendless.mediaService = MediaService()   

    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
}

