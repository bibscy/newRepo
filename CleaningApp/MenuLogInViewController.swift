//
//  MenuLogInViewController.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 24/08/2016.
//  Copyright © 2016 brev. All rights reserved.
//

import UIKit
import Firebase

class MenuLogInViewController: UIViewController, UITextFieldDelegate {

    var alertMessage = "The email or password is wrong. Please try again!"
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    @IBAction func logIn(sender: AnyObject) {
        
        
        FIRAuth.auth()?.signInWithEmail(email.text!, password: password.text!, completion: { (authData, error) in
            
            let customError = error?.localizedDescription
            if error != nil {
                print(customError)
                
                // display an alert with the error
                self.displayAlert()
                
            } else {
                print("The user has been logged in")
       
                
     //if signIn was successful, instantiate the view controller with identifier SWrevelViewidentifier
             let toMenuOptions = self.storyboard?.instantiateViewControllerWithIdentifier("SWrevelViewidentifier")
                self.presentViewController(toMenuOptions!, animated: true, completion: nil)
                
            }
        })
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make self the delegate for email & password fields to controll the behaviour of the keyboard
   self.email.delegate = self
   self.password.delegate = self
        
    }
    


    // MARK: - Navigation

    
    
    // if the user inputs a wrong email or password, display an alert
    func displayAlert() {
        let displayAlert = UIAlertController(title: "", message: self.alertMessage, preferredStyle:
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
    
    // Stop Editing on Return Key Tap. textField parameter refers to any textfield within the view
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
