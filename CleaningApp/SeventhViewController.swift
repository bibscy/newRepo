//
//  SeventhViewController.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 06/07/2016.
//  Copyright © 2016 brev. All rights reserved.
//

import UIKit
import Firebase

class SeventhViewController: UIViewController, UITextFieldDelegate {
    
 
    var rootRef = FIRDatabase.database().reference()
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetButtonOutlet: UIButton!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    var customError:String = ""
    var emailKey = "forgotEmailKey"
    
   
    override func viewDidLoad() {
        
        // make self delegate for emailTextField to control the keyboard behaviour

        self.emailTextField.delegate = self
        
        // these observers will call  keyboardWillShow/Hide functions to move the button up/down
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardDidHideNotification, object: nil)
 }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // load data from NSUserDefaults
        self.loadData(true)
    }
    
// reset password
    @IBAction func resetPassword(sender: AnyObject) {
 
        FIRAuth.auth()?.sendPasswordResetWithEmail(emailTextField.text!, completion: { (error) in
     
  if error == nil {
           self.saveEmail() // save email to NSUserDefaults
              self.performSegueWithIdentifier("fromSeventhToFifth", sender: self)
                    
                } else {
                self.customError = error!.localizedDescription
                   // display an alert with the error
                        self.displayAlert()
            }
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "fromSeventhToFifth" {
            if let destViewController = segue.destinationViewController as? FifthViewController {
                // assign checkValue a value so as to trigger a function based on its value in FifthViewController
                        destViewController.checkValue = 1
            }
         }
     }
     //save email to NSUserDefaults
    func saveEmail(){
        NSUserDefaults.standardUserDefaults().setObject(emailTextField.text, forKey: emailKey)
 }
    
    // retrieve email from NSUserdefaults
    func loadData(animation:Bool){
        if let loadEmail = NSUserDefaults.standardUserDefaults().objectForKey(emailKey) as? String {
            emailTextField.text = loadEmail
        }
    }
    
    // display an alert with an error
    func displayAlert() {
       let displayAlert = UIAlertController(title: "", message: customError, preferredStyle:
        .Alert)
            displayAlert.addAction(UIAlertAction(title: "OK",
                style: .Default, handler: { (action:UIAlertAction) in
        
       // self.emailTextField.text = ""
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
        if let userInfo = notification.userInfo {
            if let keyboardSize: CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                bottomConstraint.constant = keyboardSize.size.height
                view.setNeedsLayout()
            }
        }
    }
    
    // When keyboard is hidden, move the button to the bottom of the view
    func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.constant = 0.0
        
        view.setNeedsLayout()
    }

}



