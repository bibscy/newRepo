//
//  DetailViewController.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 13/08/2016.
//  Copyright © 2016 brev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

 
    @IBOutlet weak var dateAndTime: UILabel!
    @IBOutlet weak var flatNumber: UILabel!
    @IBOutlet weak var streetAddress: UILabel!
    @IBOutlet weak var postCode: UILabel!
    @IBOutlet weak var extras: UILabel!
    @IBOutlet weak var bookingNumberLabel: UILabel!
    
    
    @IBAction func reschedule(sender: AnyObject) {
    }

    var dateAndTimeReceived:String!
        var flatNumberReceived:String!
          var streetAddressReceived:String!
            var postCodeReceived:String!
    
    var insideCabinetsReceived:Bool!
        var insideFridgeReceived:Bool!
        var insideOvenReceived:Bool!
                var laundryWashReceived:Bool!
                var interiorWindowsReceived:Bool!
                var bookingNumberReceived:String!
    
                        var extrasArray = [String]()
    
       override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.dateAndTime.text = self.dateAndTimeReceived
        self.flatNumber.text = self.flatNumberReceived
        self.streetAddress.text = self.streetAddressReceived
        self.postCode.text = self.postCodeReceived
        self.bookingNumberLabel.text =  self.bookingNumberReceived
        StructS.myBooking = self.bookingNumberReceived
       
        if insideCabinetsReceived.boolValue == true {
            self.extrasArray.append("Inside Cabinets")
         
        }
        
        if insideFridgeReceived.boolValue == true {
             self.extrasArray.append("Inside Fridge")
        }
        
        if insideOvenReceived.boolValue == true {
              self.extrasArray.append("Inside Oven")
          
        }
        
        if laundryWashReceived.boolValue == true {
              self.extrasArray.append("Laundry wash & dry")
        }
        
        if interiorWindowsReceived.boolValue == true {
             self.extrasArray.append("Interior Windows")

            }
       
        
        
        }
    
  }

