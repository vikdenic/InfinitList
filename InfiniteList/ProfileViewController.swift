//
//  ProfileViewController.swift
//  InfiniteList
//
//  Created by Vik Denic on 2/8/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

  var backendless = Backendless.sharedInstance()

  @IBOutlet var tableView: UITableView!

  var blurbs = [Blurb]()

  override func viewDidLoad() {
    super.viewDidLoad()
    retrieveBlurbs()
  }

  func retrieveBlurbs() {
    let query = BackendlessDataQuery()
    let clause = "ownerId=\(backendless.userService.currentUser.objectId)"
    print(clause)
    //Strings in clauses need to be put between \'the string example'\
    query.whereClause = "ownerId = \'\(backendless.userService.currentUser.objectId)\'"
    // Use backendless.persistenceService to obtain a ref to a data store for the class
    let dataStore = self.backendless.persistenceService.of(Blurb.ofClass()) as IDataStore
    dataStore.find(query, response: { (retrievedCollection) -> Void in
      print("Successfully retrieved: \(retrievedCollection)")
      self.blurbs = retrievedCollection.data as! [Blurb]
      self.tableView.reloadData()
      }) { (fault) -> Void in
        print("Server reported an error: \(fault)")
    }
  }

  @IBAction func onLoggoutTapped(sender: AnyObject) {
    backendless.userService.logout({ (object) -> Void in
      self.navigationController?.popToRootViewControllerAnimated(false)
      self.performSegueWithIdentifier("profileToLoginSegue", sender: self)
      }) { (fault) -> Void in
        print("Server reported an error: \(fault)")
    }
  }

  @IBAction func onLogoutTapped(sender: AnyObject) {
    backendless.userService.logout({ (object) -> Void in
      self.performSegueWithIdentifier("profileToLoginSegue", sender: self)
      self.navigationController?.popToRootViewControllerAnimated(true)
      }) { (fault) -> Void in
        print("Server reported an error: \(fault)")
    }
  }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return blurbs.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("profileCell")! as UITableViewCell
    let blurb = self.blurbs[indexPath.row]
    cell.textLabel?.text = blurb.message
    cell.detailTextLabel?.text = blurb.authorEmail
    return cell
  }
}