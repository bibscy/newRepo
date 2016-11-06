//
//  RootController.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 13/08/2016.
//  Copyright © 2016 brev. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class RootController: UITableViewController,UISplitViewControllerDelegate {
    
    var currentUid:String!
    var dbRef:FIRDatabaseReference!
    
    // this array will hold all bookings for the logged in user
          var bookingInfo = [FireBaseData]()
            var array: NSMutableArray! = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        if FIRAuth.auth() != nil {
             self.currentUid = FIRAuth.auth()?.currentUser?.uid
        }
        dbRef = FIRDatabase.database().reference().child("Users/\(currentUid)")
 
       
        
        // self.tableView.reloadData()
        self.splitViewController?.delegate = self
        self.splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         return bookingInfo.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let booking = bookingInfo[indexPath.row]
       
        cell.textLabel?.text = "Booking# " + booking.BookingNumber
        
        return cell
    }
 
    
       override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("ShowDetail", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            
            let index = self.tableView.indexPathForSelectedRow! as NSIndexPath
            
            let nav = segue.destinationViewController as! UINavigationController
            
            let vc = nav.viewControllers[0] as! DetailViewController
            let bookingSelected = bookingInfo[index.row]
            
      
            vc.dateAndTimeReceived = bookingSelected.DateAndTime
            vc.flatNumberReceived = bookingSelected.FlatNumber
            vc.streetAddressReceived = bookingSelected.StreetAddress
            vc.postCodeReceived = bookingSelected.PostCode
            
            vc.insideCabinetsReceived = bookingSelected.insideCabinets
            vc.insideFridgeReceived = bookingSelected.insideFridge
            vc.insideOvenReceived = bookingSelected.insideOven
            vc.laundryWashReceived = bookingSelected.laundryWash
            vc.interiorWindowsReceived = bookingSelected.interiorWindows
            vc.bookingNumberReceived = bookingSelected.BookingNumber
            
            self.tableView.deselectRowAtIndexPath(index, animated: true)
        }
    }
   
    // MARK: - UISplitViewControllerDelegate
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        
        return true
    }
}


