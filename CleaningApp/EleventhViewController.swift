//
//  EleventhViewController.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 12/07/2016.
//  Copyright © 2016 brev. All rights reserved.
//

import UIKit

class EleventhViewController: UIViewController, UITextFieldDelegate {

    var fullNameKey = "fullNameEleventhViewControllerKey"
    var flatNumberKey = "flatNumberKeyEleventhViewControllerKey"
    var streetAddressKey = "streetAddressEleventhViewControllerKey"
    var phoneNumberKey = "phoneNumberEleventhViewControllerKey"
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var flatNumber: UITextField!
    @IBOutlet weak var streetAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  
    override func viewDidLoad() {
          super.viewDidLoad()
        
        print(FullData.finalSuppliesName)
              
              print(FullData.finalSuppliesAmount)
        
        // calculate the total amount for the current booking and assign it to  FullData.finalBookingAmount
        FullData.finalBookingAmount =
                         String(FullData.finalFrequecyAmount + StructS.totalExtras + FullData.finalSuppliesAmount)
                           print(" This is \(FullData.finalBookingAmount)")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardDidHideNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        // retrieve data from NSUserDefaults
        self.loadData()
        
            // capitalize the words in the textfields
           self.fullName.autocapitalizationType = .Words
              self.streetAddress.autocapitalizationType = .Words
                 self.flatNumber.autocapitalizationType = .Words
        
        // make self the delegate of the text fields change the behaviour of the keyboard 
        self.fullName.delegate = self
            self.flatNumber.delegate = self
                self.streetAddress.delegate = self
                    self.phoneNumber.delegate = self
        
    }
    

    

    @IBAction func nextButton(sender: AnyObject) {
        
       // assign textFields values to FullData
        FullData.finalfullName = self.fullName.text
        FullData.finalflatNumber = self.flatNumber.text
        FullData.finalstreetAddress = self.streetAddress.text
        FullData.finalphoneNumber = self.phoneNumber.text
            
        // save data to NSUserDefaults
        self.saveData()
    }
    
    
    func saveData(){
        NSUserDefaults.standardUserDefaults().setObject(fullName.text, forKey: fullNameKey)
        NSUserDefaults.standardUserDefaults().setObject(flatNumber.text, forKey: flatNumberKey)
        NSUserDefaults.standardUserDefaults().setObject(streetAddress.text, forKey: streetAddressKey)
        NSUserDefaults.standardUserDefaults().setObject(phoneNumber.text, forKey: phoneNumberKey)
    }
    
  
    func loadData(){
        
        
        if let fullNameRetreieved = NSUserDefaults.standardUserDefaults().objectForKey(fullNameKey) as? String {
            fullName.text = fullNameRetreieved
        }
        
        if let flatNumberRetrieved = NSUserDefaults.standardUserDefaults().objectForKey(flatNumberKey) as? String{
            flatNumber.text = flatNumberRetrieved
        }
        
        if let streetAddressRetrieved = NSUserDefaults.standardUserDefaults().objectForKey(streetAddressKey) as? String{
            streetAddress.text = streetAddressRetrieved
        }
        if let phoneNumberRetrieved = NSUserDefaults.standardUserDefaults().objectForKey(phoneNumberKey) as? String {
            phoneNumber.text = phoneNumberRetrieved
            
            FullData.finalfullName = self.fullName.text
            FullData.finalflatNumber = self.flatNumber.text
            FullData.finalstreetAddress = self.streetAddress.text
            FullData.finalphoneNumber = self.phoneNumber.text
        }
    }
    
    

    
    // When tapping outside of the keyboard, close the keyboard down
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Stop Editing on Return Key Tap. textField parameter refers to any textfield within the view
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

    
  func keyboardWillShow(notification: NSNotification) {
    if let userInfo = notification.userInfo {
        if let keyboardSize: CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            
            bottomConstraint.constant = keyboardSize.size.height 
            view.setNeedsLayout()
        }
        
    }
}

    func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.constant = 0.0
        view.setNeedsLayout()
    }

}
