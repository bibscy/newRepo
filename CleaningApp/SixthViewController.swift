//
//  SixthViewController.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 05/07/2016.
//  Copyright © 2016 brev. All rights reserved.
//

import UIKit
import Firebase

class SixthViewController: UIViewController, UITextFieldDelegate {

    var createAccountError:String?
    var logInError:String?
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // make self the delegate of the text fields to control the keyboard behaviour

        self.Email.delegate = self
          self.Password.delegate = self
        
        // these observers will call  keyboardWillShow/Hide functions to move the button up/down
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardDidHideNotification, object: nil)
  }


    
    @IBAction func createAccount(sender: AnyObject) {
        FIRAuth.auth()?.createUserWithEmail(Email.text!, password: Password.text!, completion: { (result, error) in
            
             self.createAccountError = error?.localizedDescription
            if error != nil {
                
                    // display the error
                     self.displayAlert()
                          print(self.createAccountError)
            } else {
                
    
                // log in the user,
                self.login()
                       print(result)
                
                // segue to EighthViewController
                self.performSegueWithIdentifier("fromSixthtoEighth", sender: self)
          }
      })
   }
    
        func login(){
            FIRAuth.auth()?.signInWithEmail(Email.text!, password: Password.text!, completion: { (authData, error) in
                
                self.logInError = error?.localizedDescription
             if error != nil {
                    self.showError()
                        } else {
                    // assign the email of the current user to FullData
                FullData.finalemailAddress = authData?.email
                               print("The user has been logged in")
                }
            })
        } // end of login()
    
    
    // display error when creating account
    func displayAlert(){
         let displayAlert = UIAlertController(title: "", message: self.createAccountError, preferredStyle:
        .Alert)
    displayAlert.addAction(UIAlertAction(title: "OK", style: .Default,
    handler: { (action:UIAlertAction) in
    // no code
    }))
    
    self.presentViewController(displayAlert, animated: true, completion: nil)
    } // end of displayAlert()
    
    
    
    // show error when attemting to log in
    func showError(){
            let displayAlert = UIAlertController(title: "", message: self.logInError, preferredStyle:
            .Alert)
                    displayAlert.addAction(UIAlertAction(title: "OK", style: .Default,
                         handler: { (action:UIAlertAction) in
                            // no code
      }))
                        self.presentViewController(displayAlert, animated: true, completion: nil)
    }
    
    
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


   