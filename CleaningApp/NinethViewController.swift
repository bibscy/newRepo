//
//  NinethViewController.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 11/07/2016.
//  Copyright © 2016 brev. All rights reserved.
//


import UIKit

class NinethViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var total = 0
    var hours:Double = 0.0
    var totalKey = "totalNinethViewControllerKeyP"
    let indexPathKey = "indexPathForCellSelectedNinethViewControllerKey"
    var hoursNinethKey = "hoursNinethViewControllerKey"
    var indexPathsForCellSelected: NSMutableSet = NSMutableSet()// {NSIndexPath}
    
    
    struct Item {
        var name:String // name of the row
        var selected:Bool // whether is selected or not
        var amount: Int // value of the item
        var time: Double
    }
    
    var extras = [
        Item(name:"Inside Cabinets",selected: false, amount: 5,time: 0.5),
        Item(name:"Inside Fridge",selected: false, amount: 5,time: 0.5),
        Item(name:"Inside Oven",selected: false, amount: 5,time: 0.5),
        Item(name:"Laundry wash & dry",selected: false, amount: 10,time: 1.0),
        Item(name:"Interior Windows", selected: false, amount: 5,time: 0.5)
    ]
    
    
    @IBOutlet weak var tableView: UITableView!


    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // if end of tenancy cleaning is selected in EighthViewController, segue to TenthViewController.
        if FullData.finalFrequencyName.containsString("End of tenancy cleaning") {
            self.performSegueWithIdentifier("fromNinethToTenth", sender: self)
        }
    }
    
  

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // loadData from NSUserDefaults
        self.loadData()
  
    // reload the tableView so that the header is updated with data from NSUserDefaults
    self.tableView.reloadData()
  
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return extras.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // configure the cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell     {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
            cell?.textLabel?.text = extras[indexPath.row].name
            return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // if the cell has not been selected before
          if !extras[indexPath.row].selected {
            
            // marks the cell as selected once
            extras[indexPath.row].selected = true
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
            self.total += extras[indexPath.row].amount
            self.hours += extras[indexPath.row].time
            // save the indexPath for the selected row
            indexPathsForCellSelected.addObject(indexPath)
            
              print("\(total) Selecting")
            
            // assign a true value to the row that is selected - in FullData structure
            // this info will saved in FireBase in TwelvethViewController
       extrasSelected[indexPath.row].selected = true
            
        } else {
            // marks the cell as not selected
            extras[indexPath.row].selected = false
              tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .None
                 self.total -= extras[indexPath.row].amount
                    self.hours -= extras[indexPath.row].time
                          print("\(total) hours DEselecting")
            // remove the indexPath for the selected row
             indexPathsForCellSelected.removeObject(indexPath)
            
            
            
             // assign a false value to the row that is deselected - in FullData structure
            // this info will saved in FireBase in TwelvethViewController
            extrasSelected[indexPath.row].selected = false
 }

    //save all info in NSUserDefaults
         self.saveData()
        
        // Reload the table view every time a row is selected/deselected so that our header section gets updated too with the data from the tableView
             self.tableView.reloadData()
}
    
    

    
    func saveData() {
        
        // assign total amount to StructS.totalExtras which will be used to calculate the total amount of the booking
        StructS.totalExtras = self.total
        
        // assign total number of hours to StructS.extrasHours
       StructS.extrasHours = self.hours
        print("assigning hours to StructS.extrasHours \(StructS.extrasHours)")
        
        // save indexPathsForCellSelected in NSUserDefaults
        let data = NSKeyedArchiver.archivedDataWithRootObject(indexPathsForCellSelected)
          NSUserDefaults.standardUserDefaults().setObject(data, forKey: indexPathKey)
      
       
        //save total in NSUserDefaults
        NSUserDefaults.standardUserDefaults().setObject(total, forKey: totalKey)
        
        // save total number of hours in NSUserDefaults
        NSUserDefaults.standardUserDefaults().setDouble(self.hours, forKey: hoursNinethKey)
        print("saving in NSUserDefaults\(self.hours)")
  }
    
    
    
    func loadData() {
        //retrieve indexPathForCellSelected from NSUserDefaults
     if let retrievedIndexPath = NSUserDefaults.standardUserDefaults().dataForKey(indexPathKey) {
            if let data1 = NSKeyedUnarchiver.unarchiveObjectWithData(retrievedIndexPath) as? NSMutableSet{
                indexPathsForCellSelected = data1
        }
   }

        

        
        // assign checkmark to row selected
        for item in indexPathsForCellSelected {
            
            if let indexPath = item as? NSIndexPath {
                extras[indexPath.row].selected = true
                    self.tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
                
                
                /* When loading data from NSUserDefaults, assign a true value to the row that is selected, so that we can get the amount for each row selected in TwelvethViewController.
                       extrasSelected holds the data for the extras that will be saved in Firebase
                            extrasSelected is located in FullData.swift */
                extrasSelected[indexPath.row].selected = true
                
            }
        }

        // retrieve total from NSUserDefaults
        if let totalRetrieved = NSUserDefaults.standardUserDefaults().objectForKey(totalKey) as? Int {
            self.total = totalRetrieved
            print("Retreieving total \(total)")
            
// if 'totalRetrieved' has a value assign total to StructS.totalExtras which will be used to calculate the total amount of the booking
            StructS.totalExtras = self.total
        }
        
        // retrieve hours from NSUserDefaults
        if let hoursRetrieved = NSUserDefaults.standardUserDefaults().doubleForKey(hoursNinethKey) as? Double {
              self.hours = hoursRetrieved
               StructS.extrasHours = self.hours
            
            print("Hours Retrieved is \(hoursRetrieved)")
             print(self.hours)
            
        }
    }
    
    // create a header in section and populate its labels with data
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("customheader") as! CustomerHeader_NinethViewController
        
        headerCell.dateHeaderlabel.text = StructS.headerDate
        headerCell.hourHeaderlabel.text = StructS.headerHours + " " + "-"
        headerCell.totalHoursHeaderlabel.text = String("\(Double(StructS.numberHours) + StructS.extrasHours) HOURS")
        
        headerCell.priceHeaderlabel.text = String("£\(StructS.price + StructS.totalExtras)")
        
        headerCell.backgroundColor =  UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)

        
        print("NinethViewController header called")
        print(" The value of header \(headerCell.totalHoursHeaderlabel.text)")
        return headerCell
        
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }

    
    @IBAction func nextButton(sender: AnyObject) {

    }
}
