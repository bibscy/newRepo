//
//  RearTV.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 24/08/2016.
//  Copyright © 2016 brev. All rights reserved.
//

import UIKit
import Firebase

class RearTV: UITableViewController {

    @IBOutlet weak var logInOutlet: UIButton!
    @IBOutlet weak var logOutOutlet: UIButton!

    
    @IBOutlet weak var bookingsOutlet: UIButton!
    
    @IBAction func logIn(sender: AnyObject) {
    }
    
    
    @IBAction func logOut(sender: AnyObject) {
        
        // if the current user is logged in, try to log out and if logout is successful:
        // hide: logOut button & bookings button
        // show: logIn button
      if FIRAuth.auth() != nil {
      
            do {
                try FIRAuth.auth()?.signOut()
                
                print("the user is logged out")
            } catch let error as NSError {
                print(error.localizedDescription)
                 print("the current user id is \(FIRAuth.auth()?.currentUser?.uid)")
            }
            
            self.logInOutlet.hidden = false
            self.logOutOutlet.hidden = true
            self.bookingsOutlet.hidden = true
        } // end of if.. FIRAuth.auth()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        FIRAuth.auth()!.addAuthStateDidChangeListener() { (auth, user) in
            if let user = user {
                
                // if the user is logged in
                // hide: logIn Button
                // show: logOut button & bookings button
                self.logInOutlet.hidden = true
                self.logOutOutlet.hidden = false
                self.bookingsOutlet.hidden = false

                print("User is signed in with uid:", user.uid)
                
            } else {
                
                // if the user is logged out
                // hide: logOut button & bookings button
                // show: logIn button
                
                self.logInOutlet.hidden = false
                self.logOutOutlet.hidden = true
                self.bookingsOutlet.hidden = true
                print("No user is signed in.")
            }
        }
        
        

       
    }



    /*
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
 

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    } */

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
