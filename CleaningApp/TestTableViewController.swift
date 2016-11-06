//
//  TestTableViewController.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 10/08/2016.
//  Copyright © 2016 brev. All rights reserved.
//


import UIKit
import FirebaseDatabase
import FirebaseAuth

class TestTableViewController: UITableViewController {
   
    var dbRef: FIRDatabaseReference!
      var bookingInfo = [FireBaseData]() // this will hold all bookings for the logged in user

    override func viewDidLoad() {
        super.viewDidLoad()

        // create a reference to the current signed in user
        dbRef = FIRDatabase.database().reference().child("Users/\(StructS.myUid)")
        startObservingDB()
    }

    func startObservingDB() {
        dbRef.observeEventType(.Value, withBlock: { (snapshot: FIRDataSnapshot) in
            var newBookingInfo = [FireBaseData]()
              for booking in snapshot.children {
                let bookingItem = FireBaseData(snapshot: booking as! FIRDataSnapshot)
                
                  // append the objects received from our database to newBookingInfo array
                     newBookingInfo.append(bookingItem)
            }
             // assign the elements of newBookingInfo array to  bookingInfo
             self.bookingInfo = newBookingInfo
                self.tableView.reloadData()
            
        }) { (error:NSError) in
                print(error.description)
    }
 }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingInfo.count
    }

 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let booking = bookingInfo[indexPath.row]
    cell.textLabel?.text = booking.EmailAddress

        return cell
    }

}



/*
 // Override to support rearranging the table view.
 override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */
