//
//  ThirdViewController.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 12/05/2016.
//  Copyright © 2016 brev. All rights reserved.
//

import Foundation
import UIKit


class ThirdViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var bedPicker: UIPickerView!
    @IBOutlet weak var bathPicker: UIPickerView!
    var bedOptions = ["0","1","2","3","4","5","6","7","8","9","10"]
    var bathOptions = ["0","1","2","3","4","5","6","7","8","9","10"]
    var selectedBathRow = 0
    var selectedBedRow = 0
    
    var total:Int!
    
    @IBAction func nextButton(sender: AnyObject) {
          // save textField input
            let defaults = NSUserDefaults.standardUserDefaults()
        
           defaults.setObject(selectedBedRow, forKey: "selectedBedRow")
            defaults.setObject(selectedBathRow, forKey: "selectedBathRow")
              defaults.synchronize()
        
        // assign selectedBathRow & selectedBedRow to FullData structure
         FullData.finalSelectedBedRow = selectedBedRow
         FullData.finalSelectedBathRow = selectedBathRow
        StructS.selectedBed = selectedBedRow
       StructS.selectedBath = selectedBathRow
 }
 


    override func viewDidLoad() {
        super.viewDidLoad()
       
        //set self as delegate and datasource for bedPicker & bathPicker
         bedPicker.delegate = self
         bedPicker.dataSource = self
        
        bathPicker.delegate = self
        bathPicker.dataSource = self
        
       
         // Retrieving Data From NSUserDefaults
         if let defaultsBed = NSUserDefaults.standardUserDefaults().objectForKey("selectedBedRow") {
            if let defaultsBath = NSUserDefaults.standardUserDefaults().objectForKey("selectedBathRow"){
                
              self.selectedBathRow = (defaultsBath as? Int)!
                bathPicker.selectRow(selectedBathRow, inComponent: 0, animated: true)
                
                 print(selectedBathRow)
                
                // add background color and text to the view
                view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
                let displayLabel = UILabel(frame: CGRectMake(20.0, 100, 190, 30.0))
                displayLabel.text = "Tell us about your place"
                displayLabel.font = displayLabel.font.fontWithSize(17)
                displayLabel.numberOfLines = 1
                displayLabel.sizeToFit()
                displayLabel.textAlignment = .Center
                displayLabel.textColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0)
                view.addSubview(displayLabel)
                
            }
         
            self.selectedBedRow = (defaultsBed as? Int)!
          bedPicker.selectRow(selectedBedRow, inComponent: 0, animated: true)
             print(selectedBedRow)
            
    } // end of if let defaultsBed 
}
    

    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
        return bedOptions[row]
            } else {
                return bathOptions[row]
        }
    }
    

        func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            
            if pickerView.tag == 1 {
        return bedOptions.count
          } else {
                return bathOptions.count
       }
  }
    
    
   
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1 {
            selectedBedRow = row
            print(selectedBedRow )
        } else if pickerView.tag == 2 {
            selectedBathRow = row
            print(selectedBathRow)
        }
    }
    
}