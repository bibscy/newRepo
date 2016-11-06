//
//  SecondViewController.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 11/05/2016.
//  Copyright © 2016 brev. All rights reserved.
// some references for textfields   grokswift.com/uitextfield/

import Foundation
import UIKit


class SecondViewController: UIViewController, UITextFieldDelegate {

 
    @IBOutlet weak var bottomButton: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!
    
 
    @IBOutlet weak var scrollView: UIScrollView!

    @IBAction func nextButton(sender: AnyObject) {
         // save textField input
           let defaults = NSUserDefaults.standardUserDefaults()
                  defaults.setObject(textField.text, forKey: "postcode")
        
                     // assign the postcode to FullData structure
                        FullData.finalPostCode = textField.text
        
        if textField.text?.characters.count > 10 || textField.text?.characters.count < 6 {
            displayAlert()
        }
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // make self the delegate for the textField
               self.textField.delegate = self
        
           // capitalize all characters in the textfield
               self.textField.autocapitalizationType = .AllCharacters
        
    
        
        // Retrieving Data From NSUserDefaults
        if let defaults = NSUserDefaults.standardUserDefaults().objectForKey("postcode") {
              self.textField.text = defaults as? String
            
        
            // these observers will call  keyboardWillShow/Hide functions to move the button up/down
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
            
            
            // add background color and text to the view
            view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
            let displayLabel = UILabel(frame: CGRectMake(20.0, 100, 190, 30.0))
            displayLabel.text = "Where are you located?"
            displayLabel.font = displayLabel.font.fontWithSize(17)
            displayLabel.numberOfLines = 1
            displayLabel.sizeToFit()
            displayLabel.textAlignment = .Center
            displayLabel.textColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0)
            view.addSubview(displayLabel)
     }
 }
    
    // allow the user to input only alphanumberic characters
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let set = NSCharacterSet(charactersInString: "ABCDEFGHIJKLMONPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ").invertedSet
        return string.rangeOfCharacterFromSet(set) == nil
        
    }
    

    
    
    //display an error message
    func displayAlert() {
        let displayAlert = UIAlertController(title: "", message: "The postcode is badly formatted.       The total length must be 6,7, or 8 characters, a gap (space character) must be included.", preferredStyle:
            .Alert)
        displayAlert.addAction(UIAlertAction(title: "OK", style: .Default,
            handler: { (action:UIAlertAction) in
                // no code
        }))
        
        self.presentViewController(displayAlert, animated: true, completion: nil)
    } // end of displayAlert()
    
    

    

    // When tapping outside of the keyboard, close the keyboard down
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Stop Editing on Return Key Tap
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    // when keyboard is about to show assign the height of the keyboard to bottomConstraint.constant of our button so that it will move up

   
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if view.frame.origin.y == 0 {

                let height = keyboardSize.height
               bottomButton.constant = height
                 self.view.layoutIfNeeded()
            
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
        
                print("keyboard is hidden")
                let height = keyboardSize.height
                 bottomButton.constant = 2
                 self.view.layoutIfNeeded()
         
            
        }
    }
    
    
}


