
//  ViewController.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 10/05/2016.
//  Copyright © 2016 brev. All rights reserved.
//

import UIKit
import WatchKit


class ViewController: UIViewController {

  var checkit = 1
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBAction func BookCleaningButton() {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
           
        }
        
    }


    
    @IBAction func goToPageTwo() {
        
        
    }
     
}

