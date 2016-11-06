//
//  TenthViewController.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 12/07/2016.
//  Copyright © 2016 brev. All rights reserved.
//

import UIKit

class TenthViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var total = 0
    var totalKey = "totalTenthViewControllerKey"
    var amountKey = "amountTenthViewControllerKey"
    var indexPathForCellKey = "indexPathForCellTenthViewControllerKey"
    var indexPathForCellSelected: NSIndexPath?
    
    struct Item {
        var name:String // name of the row
        var selected:Bool // whether is selected or not
        var amount: Int // value of the item
    }
    
    var supplies = [
        
        Item(name:"Bring cleaning supplies",selected: false, amount: 5),
        Item(name:"I have cleaning supplies",selected: false, amount: 0)
    ]
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.tableView.delegate = self
          self.tableView.delegate = self
        tableView.scrollEnabled = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
         self.loadData()
       self.tableView.reloadData()
    }
    
    
    // when the back button is pressed viewWillDisappear is called
    // isMovingFromParentViewController is called
    override func viewWillDisappear(animated : Bool) {
        super.viewWillDisappear(animated)
        
        // bug -> view will disappear when moving to next view controller too
        if self.isMovingFromParentViewController() {
            
            // if End of tenancy was selected when Back button is pressed, pop view controllers until EighthViewController is at the top of the navigation stack.
            
          if let switchController = self.navigationController?.viewControllers[5] as? EighthViewController {
                if FullData.finalFrequencyName.containsString("End of tenancy cleaning") {
                       self.navigationController?.popToViewController(switchController, animated: true)
       }
    }
  } // end of isMovingFromParentViewController()
}
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supplies.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // configure the cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell     {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
            cell?.textLabel?.text = supplies[indexPath.row].name
            return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if !supplies[indexPath.row].selected {
            
            // this avoid set initial value for the first time
            if let index = indexPathForCellSelected { // if exists, make changes
                // clear the previous cell
                supplies[index.row].selected = false
                tableView.cellForRowAtIndexPath(index)?.accessoryType = .None
                self.total -= supplies[index.row].amount
                print(total)
                
                
            }
            
            // mark the new one
            supplies[indexPath.row].selected = true
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
            
            indexPathForCellSelected = indexPath
            self.total += supplies[indexPath.row].amount
           print(total)
            // assign the name & amount for the row selected to finalSuppliesName & finalSuppliesAmount to save in FullData
            
            FullData.finalSuppliesName = supplies[indexPath.row].name
            FullData.finalSuppliesAmount = supplies[indexPath.row].amount
            
            
              //save to NSUserDefaults
                 self.saveData()

            
            // Reload the table view so that our header section gets updated too with the data from the tableView
            self.tableView.reloadData()
        }
   }
    
    
    func saveData() {
        if indexPathForCellSelected != nil { // used to check if there is a selected row in the table
            
            //save indexPathForCellSelected in NSUserDefaults
            let data = NSKeyedArchiver.archivedDataWithRootObject(indexPathForCellSelected!)
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: indexPathForCellKey)
            
            //save total in NSUserDefaults
            NSUserDefaults.standardUserDefaults().setObject(total, forKey: totalKey)
            
            // save amount in NSUserDefaults
            NSUserDefaults.standardUserDefaults().setObject(supplies[indexPathForCellSelected!.row].amount, forKey: amountKey)
            
        } // end of if indexPathForCellSelected
    }
    
    
    func loadData() {

        if let retrievedIndexPath = NSUserDefaults.standardUserDefaults().dataForKey(indexPathForCellKey) {
            if let data1 = NSKeyedUnarchiver.unarchiveObjectWithData(retrievedIndexPath) as? NSIndexPath {
                indexPathForCellSelected = data1
                print("indexExists")
                              /* Inform the delegate that the row has already been selected.
                                                             */
          // self.tableView(self.tableView, didSelectRowAtIndexPath: indexPathForCellSelected!)
            }
            
     
            
            // retrieve total from NSUserDefaults
            if let totalRetrieved = NSUserDefaults.standardUserDefaults().objectForKey(totalKey) as? Int {
                total = totalRetrieved
                print(total)
            }
            
            // retrieve amount for each item
            if let itemAmount =  NSUserDefaults.standardUserDefaults().objectForKey(amountKey) as? Int {
                let myIndexpath = indexPathForCellSelected?.row
                supplies[myIndexpath!].amount = itemAmount
                
                tableView.cellForRowAtIndexPath(indexPathForCellSelected!)?.accessoryType = .Checkmark
                
                // assign the name & amount for the row selected to finalSuppliesName & finalSuppliesAmount to save in FullData
                FullData.finalSuppliesName = supplies[indexPathForCellSelected!.row].name
                FullData.finalSuppliesAmount = supplies[indexPathForCellSelected!.row].amount
                
            }
      
        } //  if let retrievedIndexPath
        
        
        // handle the selection of the row so as to update the values of labels in section header.
        // if indexPathForCellSelected == nil, select a default type of cleaning for the first time
        if indexPathForCellSelected == nil {
            print("its'nil")
            // construct an indexPath for the row we want to select when no previous row was selected ( not already saved in NSUserDefaults)
            let rowToSelect:NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
            
            // select the row at `rowToSelect` indexPath. This will just register the selectd row, However,the code that you have in tableView:didSelectRowAtIndexPath: is not yet executed because the delegate for the tablewView object in the ViewController has not been called yet.
            self.tableView.selectRowAtIndexPath(rowToSelect, animated: true, scrollPosition: UITableViewScrollPosition.None)
            
            // inform the delegate that the row was selected
            // stackoverflow.com/questions/24787098/programmatically-emulate-the-selection-in-uitableviewcontroller-in-swift
            self.tableView(self.tableView, didSelectRowAtIndexPath: rowToSelect)
            
        }  // end of  if indexPathForCellSelected == nil
        
        
      }
    
    
    // create a header in section and populate its labels with data
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("customheader") as! CustomHeader_TenthViewController
        
        headerCell.dateHeaderlabel.text = StructS.headerDate
        headerCell.hourHeaderlabel.text = StructS.headerHours + " " + "-"
        headerCell.totalHoursHeaderlabel.text = String("\(Double(StructS.numberHours) + StructS.extrasHours) HOURS")

        headerCell.priceHeaderlabel.text = String("£\(StructS.price + StructS.totalExtras +  FullData.finalSuppliesAmount)")
        print("FullData.finalSuppliesAmount")
        headerCell.backgroundColor =  UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        print("HeadCalled")
        return headerCell
        
    }
    
    // specify the header of the header * without this the header will not be rendered on the view
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
   
    
    // add a footer
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 80))
                footerView.backgroundColor =  UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        
     let displayLabel = UILabel(frame: CGRectMake(8, 15, tableView.frame.size.width - 8, 20))
            displayLabel.text = "\n" + "\n" + "\n" + " Cleaning supplies include kitchen cleaner, bathroom cleaner, window & glass cleaner, toilet disinfectant and oven cleaner. We are unable to supply a vacuum, broom or mop."
              displayLabel.font = displayLabel.font.fontWithSize(17)
               
                displayLabel.numberOfLines = 0
                  displayLabel.sizeToFit()
                     displayLabel.textAlignment = .Center
                         displayLabel.textColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0)
        
     
        
       
        footerView.addSubview(displayLabel)
        
        
        return footerView
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 430
    }

    
}






