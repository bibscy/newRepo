//
//  FifthViewController.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 04/07/2016.
//  Copyright © 2016 brev. All rights reserved.
// Log In Page

import UIKit
import Firebase

class FifthViewController: UIViewController, UITextFieldDelegate {

    // date and time value received from FourthViewController
var dateAndTimeSelected = NSDate()
var dateFormatter = NSDateFormatter()
    
    
    
    var checkValue:Int?
    var alertMessage = "The email or password is wrong. Please try again!"
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var createAccountOutlet: UIButton!
    
    @IBOutlet weak var forgotOutlet: UIButton!
    
    var emailKey = "KeyForEmail"
    var passwordKey = "KeyForPassword"

    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  
    @IBAction func logInButton(sender: AnyObject) {
        FIRAuth.auth()?.signInWithEmail(email.text!, password: password.text!, completion: { (authData, error) in
            
            let customError = error?.localizedDescription
                 if error != nil {
                 print(customError)
                    
   // display an alert
    self.displayAlert()
        } else {
           // save email and password to NSUserDefaults
              self.saveLogInData()
                print("The user has been logged in")
                
                // assign email address to FullData structure
                FullData.finalemailAddress = authData!.email
                    
                // segue to EighthViewController
                 self.performSegueWithIdentifier("fromFifthtoEighth", sender: self)
                    
            }
        })  
    }
 
    
  
    
    override func viewDidLoad() {
// make self the delegate for both the email & password fields to control the keyboard behaviour
          self.email.delegate = self
            self.password.delegate = self
        
        
// these observers will call  keyboardWillShow/Hide functions to move the button up/down
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardDidHideNotification, object: nil)

        
        
// check if dateAndTimeSelected received the value from FourthViewController
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
            let convertedDate = dateFormatter.stringFromDate(dateAndTimeSelected)
                print(convertedDate)
   
        //if all checks are successful in 7th ViewController, segue to FifthViewController and display an alert instructing the user to check his email address to reset his password
        if self.checkValue == 1 {
            loadAlert()
    }
        
// if the current user has already logged in from MenuLogInViewController, segue fromFifthtoEighth view controller
        FIRAuth.auth()!.addAuthStateDidChangeListener() { (auth, user) in
            if let user = user {
            
             FullData.finalemailAddress = user.email
           // segue to EighthViewController
                  self.performSegueWithIdentifier("fromFifthtoEighth", sender: self)
     
      }
   }
 }


  
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // load data from NSUserDefaults
        loadData(true)

    }

        func saveLogInData() {
            NSUserDefaults.standardUserDefaults().setObject(self.email.text, forKey: self.emailKey)
            NSUserDefaults.standardUserDefaults().setObject(self.password.text, forKey: self.passwordKey)
        
    }
    
     // Retrieve data from NSUserDefaults
    func loadData(animation:Bool){
        if let loadEmail = NSUserDefaults.standardUserDefaults().objectForKey(self.emailKey) as? String {
            self.email.text = loadEmail 
     }
        if let loadPassword = NSUserDefaults.standardUserDefaults().objectForKey(self.passwordKey) as? String {
            self.password.text = loadPassword
        }
    }
    
    
    
 //if all checks are successful in 7th ViewController, segue to FifthViewController and display an alert
    
    func loadAlert() {
              let displayAlert = UIAlertController(title: "", message: "Click on the link received in the email to reset your password", preferredStyle:
            .Alert)
                 displayAlert.addAction(UIAlertAction(title: "OK", style: .Default,
                           handler: { (action:UIAlertAction) in
            
                      // reset the text field for the password
                         self.password.text = ""
           }))
                self.presentViewController(displayAlert, animated: true, completion: nil)
 }     // end of loadAlert()
    
    
    
    
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
    
    
    // when keyboard is about to show assign the height of the keyboard to bottomConstraint.constant of our button so that it will move up
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize: CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                
              
                   bottomConstraint.constant = keyboardSize.size.height
                       createAccountOutlet.hidden = true
                            forgotOutlet.hidden = true
                     view.setNeedsLayout()
         }
      }
  }
    
     // When keyboard is hidden, move the button to the bottom of the view
    func keyboardWillHide(notification: NSNotification) {
       
           bottomConstraint.constant = 0.0
                createAccountOutlet.hidden = false
                  forgotOutlet.hidden = false
       
        view.setNeedsLayout()
    }

}
