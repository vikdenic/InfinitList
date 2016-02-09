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

  @IBOutlet var tableView: UITableView!

  var blurbs = [Blurb]()

  override func viewDidLoad() {
    super.viewDidLoad()
    checkForCurrentUser()
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    retrieveBlurbs()
  }

  func retrieveBlurbs() {
    let query = BackendlessDataQuery()
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

  func checkForCurrentUser() {
    if backendless.userService.currentUser == nil {
      print("No current user")
      performSegueWithIdentifier("feedToLoginSegue", sender: self)
    } else {
      print("Current user is: \(Backendless().userService.currentUser)")
    }
  }

  func createNewBlurb(message : String) {
    let blurb = Blurb()
    blurb.message = message
    blurb.authorEmail = backendless.userService.currentUser.email
    backendless.persistenceService.of(Blurb.ofClass()).save(blurb, response: { (savedBlurb) -> Void in
        print("successfully saved blurb")
      }) { (fault) -> Void in
        print("Server reported an error: \(fault)")
    }
  }

  @IBAction func onAddButtonTapped(sender: UIBarButtonItem) {
    let alert = UIAlertController(title: "Compose New Blurb", message: nil, preferredStyle: .Alert)

    let saveAction = UIAlertAction(title: "Submit", style: .Default) { (action) -> Void in
      //TODO: Create and save blurb object
      self.createNewBlurb(alert.textFields![0].text!)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)

    alert.addAction(saveAction)
    alert.addAction(cancelAction)

    alert.addTextFieldWithConfigurationHandler(nil)

    presentViewController(alert, animated: true, completion: nil)
  }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return blurbs.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("feedCell")! as UITableViewCell
    cell.textLabel?.text = self.blurbs[indexPath.row].message
    return cell
  }
}