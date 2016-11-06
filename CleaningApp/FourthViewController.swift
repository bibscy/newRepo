
//  FourthViewController.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 02/07/2016.
//  Copyright © 2016 brev. All rights reserved.
//

import Foundation
import UIKit


class FourthViewController: UIViewController {
    
    let alertMessage = "Please choose a time betwen 7:00 - 19:00."
    
    @IBOutlet weak var myDatePicker: UIDatePicker!
                    var currentTime = NSDate()
                    let timeRestricted = [00,0,1,2,3,4,5,6,7,19,20,21,22,23]
                    var dateComponents = NSDateComponents()
                    var dateFormatter:NSDateFormatter = NSDateFormatter()
                    var hourComponents:Int = 0
                    var dateAndTime = NSDate()
                    let dateKey = "dateAndTimeKey"
                    let hourKey = "hourComponentsKey"
    


   
    override func viewDidLoad() {
        super.viewDidLoad()
      

        // load current time as minimum date
           self.myDatePicker.minimumDate = NSDate(timeInterval: 1, sinceDate: currentTime)
        
             myDatePicker.addTarget(self, action: #selector(self.datePickerAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        // add background color and text to the view
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        let header = UILabel(frame: CGRectMake(20.0, 100, 190, 30.0))
        header.text = "Tell us about your place"
        header.font = header.font.fontWithSize(17)
        header.numberOfLines = 1
        header.sizeToFit()
        header.textAlignment = .Center
        header.textColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0)
        view.addSubview(header)
        
        let footer = UILabel(frame: CGRectMake(20.0, 400, 190, 30.0))
        footer.text = "Cancel or reschedule anytime."
        footer.font = footer.font.fontWithSize(17)
        footer.numberOfLines = 1
        footer.sizeToFit()
        footer.textAlignment = .Center
        footer.textColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0)
view.addSubview(footer)
    

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadDate(true)
    }
    
  
    func datePickerAction(sender: UIDatePicker) {
        
        let timeSelected = sender.date
            dateAndTime = timeSelected
        
        
        let unitFlags: NSCalendarUnit = [.Hour]
        let components = NSCalendar.currentCalendar().components(unitFlags, fromDate: timeSelected)
        let hour = components.hour
        hourComponents = hour
      }
   


    
    @IBAction func nextButton(sender: AnyObject) {
        print(hourComponents)
         savePickerData() // save date to NSUserDefaults
        if timeRestricted.contains(hourComponents) {
            
            // display an alert
             let myAlert = UIAlertController(title: "", message: alertMessage, preferredStyle:
                .Alert)
                   myAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action:UIAlertAction) in
                // no action
            }))
            self.presentViewController(myAlert, animated: true, completion: nil)
            
                    } else {
            
                            performSegueWithIdentifier("toFifthViewController", sender: self)
            
         }
     }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toFifthViewController" {
            if let destViewController = segue.destinationViewController as? FifthViewController {
                
                destViewController.dateAndTimeSelected = dateAndTime
                
                // assign dateAndTime to FullData structure
                dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm"
                FullData.finalDateAndTime = dateFormatter.stringFromDate(dateAndTime)
                
                // assign a different date format to  StructS.headerDate which will be used to display the date in the header
                dateFormatter.dateFormat = "EEE, dd MMM"
                StructS.headerDate = dateFormatter.stringFromDate(dateAndTime)
                
                 // assign a different date format to   StructS.headerHours
                dateFormatter.dateFormat = "HH:mm"
                StructS.headerHours = dateFormatter.stringFromDate(dateAndTime)
            }
        }
    }
    
   func savePickerData() {
       
        //save date and time to NSUserDefaults
        NSUserDefaults.standardUserDefaults().setObject(myDatePicker.date, forKey: dateKey)
            NSUserDefaults.standardUserDefaults().setObject(hourComponents, forKey: hourKey)
     }
    
    
    // retrieve date and time from NSUserDefaults
    func loadDate(animation:Bool) {
        if let loadedDate = NSUserDefaults.standardUserDefaults().objectForKey(dateKey) as? NSDate {
            myDatePicker.setDate(loadedDate, animated: animation)
                dateAndTime = loadedDate // update the date we are sending to next viewController
        }
       
        if let loadHour = NSUserDefaults.standardUserDefaults().objectForKey(hourKey) as? Int {
           hourComponents = loadHour
           
            }
          }
        }



