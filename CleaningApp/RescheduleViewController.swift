//
//  RescheduleViewController.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 17/08/2016.
//  Copyright © 2016 brev. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RescheduleViewController: UIViewController {

    var dbRef:FIRDatabaseReference!
    var currentUid:String!
                
        @IBOutlet weak var rescheduleDatePicker: UIDatePicker!
        var alertMessage = "Please choose a time betwen 7:00 - 19:00."
        var currentTime = NSDate()
        let timeRestricted = [0,1,2,3,4,5,6,7,19,20,21,22,23]
        var dateComponents = NSDateComponents()
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        var hourComponents:Int = 0
        var dateAndTime = NSDate()
        let dateKey = "dateAndTimeKeyRescheduleViewController"
        let hourKey = "hourComponentsKeyRescheduleViewController"
        

        override func viewDidLoad() {
               super.viewDidLoad()
            
            
            // load current time as minimum date
            self.rescheduleDatePicker.minimumDate = NSDate(timeInterval: 1, sinceDate: currentTime)
            
            // Call datePickerAction when rescheduleDatePicker value is changed
            rescheduleDatePicker.addTarget(self, action: #selector(self.datePickerAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
            
            
        }
        
        override func viewDidAppear(animated: Bool) {
            super.viewDidAppear(animated)
            // retrieve date and time from NSUserDefaults
            loadDate(true)
        }
        
        
        func datePickerAction(sender: UIDatePicker) {
            
            let timeSelected = sender.date
            dateAndTime = timeSelected
            
            // extract hour component from timeSelected in rescheduleDatePicker
            let unitFlags: NSCalendarUnit = [.Hour]
            let components = NSCalendar.currentCalendar().components(unitFlags, fromDate: timeSelected)
            let hour = components.hour
            hourComponents = hour
        }
        
        
        
        
        @IBAction func nextButton(sender: AnyObject) {
            print(hourComponents)
            savePickerData() // save date to NSUserDefaults
            
            // check if hour selected is included in timeRestricted
            if timeRestricted.contains(hourComponents){
                
                //display the error
                self.displayAlert()
                
            } else {
                
                performSegueWithIdentifier("toRescheduleCompleted", sender: self)
            }
        }
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "toRescheduleCompleted" {
                if let destViewController = segue.destinationViewController as? RescheduleCompletedViewController {
                    
                    destViewController.dateAndTimeSelected = dateAndTime
                    
            
                        
                
                    // THINK IF YOU NEED TO ASSIGN THIS DATE TO FullData in this case *****
                    // assign dateAndTime to FullData structure
                    dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm"
                    FullData.finalDateAndTime = dateFormatter.stringFromDate(dateAndTime)
                    
                   
                    
                    if FIRAuth.auth() != nil {
                        currentUid = FIRAuth.auth()?.currentUser?.uid
                    }
                    
                    // Updating  Database
                    // create a reference to the current signed in user and its specific booking loaded in DetailViewController
               dbRef = FIRDatabase.database().reference().child("Users/\(currentUid)/\(StructS.myBooking)")
                    
                    dbRef.updateChildValues(["DateAndTime" :  FullData.finalDateAndTime])
                    
                    
                }
            }
        }
        
        func savePickerData() {
            
            //save date and time to NSUserDefaults
            NSUserDefaults.standardUserDefaults().setObject(rescheduleDatePicker.date, forKey: dateKey)
            NSUserDefaults.standardUserDefaults().setObject(hourComponents, forKey: hourKey)
        }
        
        
        // retrieve date and time from NSUserDefaults
        func loadDate(animation:Bool) {
            if let loadedDate = NSUserDefaults.standardUserDefaults().objectForKey(dateKey) as? NSDate {
                rescheduleDatePicker.setDate(loadedDate, animated: animation)
                dateAndTime = loadedDate // update the date we are sending to next viewController
            }
            
            if let loadHour = NSUserDefaults.standardUserDefaults().objectForKey(hourKey) as? Int {
                hourComponents = loadHour
        }
    }
    
    
    // display an alert with the error
    func displayAlert() {
    let myAlert = UIAlertController(title: "", message: self.alertMessage, preferredStyle:
        .Alert)
    myAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action:UIAlertAction) in
    // no action
    }))
    self.presentViewController(myAlert, animated: true, completion: nil)
    }
}