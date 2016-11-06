//
//  EighthViewController.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 07/07/2016.
//  Copyright © 2016 brev. All rights reserved.


import UIKit
import Firebase

class EighthViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    struct Item {
        var name:String // name of the row
        var selected:Bool // whether is selected or not
        var amount: Int // value of the item
    }
    
    var frequency = [
        
        Item(name:"Every week",selected: false, amount: 0),
        Item(name:"Every 2 weeks",selected: false, amount: 0),
        Item(name:"Every 4 weeks",selected: false, amount: 0),
        Item(name:"Once",selected: false, amount: 0),
        Item(name:"End of tenancy cleaning", selected: false, amount: 0)
    ]
    
    var frequencyTotalPrice = 0
    // var total = 0
    var indexPathForCellSelected: NSIndexPath?
    @IBOutlet weak var tableView: UITableView!

    let indexKey = "indexPathForCellSelected"
    let totalKey = "frequencyTotalKeyEighthViewController"
    let amountKey = "amount"
    
    var dateFormatter:NSDateFormatter = NSDateFormatter()

    override func viewDidLoad() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
      
 }
    

    
    // when the back button is pressed viewWillDisappear is called
    // isMovingFromParentViewController is called
    override func viewWillDisappear(animated : Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParentViewController() {
            
            // if user is logged in, when back button is pressed, pop view controllers until FourthViewController is at the top of the navigation stack.
            if FIRAuth.auth()?.currentUser?.email != nil {
         
                if let switchController = self.navigationController?.viewControllers[3] as? FourthViewController {
                    
                         self.navigationController?.popToViewController(switchController, animated: true)
            }
         }
      } // end of isMovingFromParentViewController()
  }
       
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
 
        
        // retrieve indexPathForCellSelected from NSUserDefaults
if let retrievedIndexPath = NSUserDefaults.standardUserDefaults().dataForKey(indexKey) {
    if let data1 = NSKeyedUnarchiver.unarchiveObjectWithData(retrievedIndexPath) as? NSIndexPath {
        indexPathForCellSelected = data1
      
 /* Inform the delegate that the row has already been selected.
         
          When calling 'tableView:didSelectRowAtIndexPath:', it will calculate the total amount depending on the type of cleaning:
               Weekly, End of Tenancy..etc
                 Call calculateTotal() function which is using `indexPathForCellSelected`
                         to calculate the total */
               self.tableView(self.tableView, didSelectRowAtIndexPath: indexPathForCellSelected!)
        
// assign the indexPath retrieved to StructS.indexPath
    StructS.indexPath = indexPathForCellSelected
        
         // assign StructS.price to  self.frequencyTotalPrice
                    self.frequencyTotalPrice = StructS.price
        
              // assign self.frequencyTotalPrice to FullData.finalFrequecyAmount
                    FullData.finalFrequecyAmount = self.frequencyTotalPrice
        
// assign a Checkmark to the row with the corresponding indexPathForCellSelected retrieved
             tableView.cellForRowAtIndexPath(indexPathForCellSelected!)?.accessoryType = .Checkmark
        
            // assign frequency[indexPath.row].name to FullData structure
                FullData.finalFrequencyName = frequency[indexPathForCellSelected!.row].name 
 }
 
            /* 
             retrieve total from NSUserDefaults
                if let totalRetrieved = NSUserDefaults.standardUserDefaults().objectForKey(totalKey) as? Int {
                     total = totalRetrieved
                      print(total)
            } */
            
    
           /* retrieve the amount for the row selected
                  if let itemAmount =  NSUserDefaults.standardUserDefaults().objectForKey(amountKey) as? Int {
                          let myIndexpath = indexPathForCellSelected?.row
                               frequency[myIndexpath!].amount = itemAmount    } */
        }
        
        // handle the selection of the row so as to update the values of labels in section header. 
       // if indexPathForCellSelected == nil, select a default type of cleaning for the first time
        if indexPathForCellSelected == nil {
            // construct an indexPath for the row we want to select when no previous row was selected ( not already saved in NSUserDefaults)
        let rowToSelect:NSIndexPath = NSIndexPath(forRow: 1, inSection: 0)
            
            // select the row at `rowToSelect` indexPath. This will just register the selectd row, However,the code that you have in tableView:didSelectRowAtIndexPath: is not yet executed because the delegate for the tablewView object in the ViewController has not been called yet. 
          self.tableView.selectRowAtIndexPath(rowToSelect, animated: true, scrollPosition: UITableViewScrollPosition.None)
            
            // inform the delegate that the row was selected
            // stackoverflow.com/questions/24787098/programmatically-emulate-the-selection-in-uitableviewcontroller-in-swift
            self.tableView(self.tableView, didSelectRowAtIndexPath: rowToSelect)
        }
      
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frequency.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // configure the cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell     {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
            cell?.textLabel?.text = frequency[indexPath.row].name
            return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        StructS.indexPath = indexPath
        
        if !frequency[indexPath.row].selected {
            
            // this avoid set initial value for the first time
            if let index = indexPathForCellSelected {
                // clear the previous cell
                frequency[index.row].selected = false
                    tableView.cellForRowAtIndexPath(index)?.accessoryType = .None
             
             
                      //  self.total -= frequency[index.row].amount
            }
            
            // mark the new one
            frequency[indexPath.row].selected = true
                tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
                   // self.total += frequency[indexPath.row].amount
                        indexPathForCellSelected = indexPath
         

            // assign frequency[indexPath.row].name to FullData structure
            FullData.finalFrequencyName = frequency[indexPath.row].name
        
            
            
           /* Calculate the total amount depending on the type of cleaning:
            Weekly, End of Tenancy..etc 
              FrequencyAmount is in FullData */
                 FrequencyAmount.calculateTotal()
            
            // assign the amount calculated by calculateTotal() to frequencyTotalPrice
                self.frequencyTotalPrice = StructS.price
            
                // assign frequencyTotalPrice to FullData.finalFrequecyAmount to be stored in FireBase
                    FullData.finalFrequecyAmount = self.frequencyTotalPrice
            
            
            
            
                //save indexPathForCellSelected in NSUserDefaults
                    if indexPathForCellSelected != nil { // used to check if there is a selected row in the table

                let data = NSKeyedArchiver.archivedDataWithRootObject(indexPathForCellSelected!)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: indexKey)
                
                        
                //save frequencyTotalPrice in NSUserDefaults
              // NSUserDefaults.standardUserDefaults().setObject(total, forKey: totalKey)
                
                // save amount in NSUserDefaults
      //    NSUserDefaults.standardUserDefaults().setObject(frequency[indexPath.row].amount, forKey: amountKey)
                        
                // Reload the table view so that our header section gets updated too with the data from the tableView
                       self.tableView.reloadData()
          
      } // end of if indexPathForCellSelected
   }
}
    
    // create a header in section and populate its labels with data
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("customheader") as! CustomHeader
        
        headerCell.dateHeaderlabel.text = StructS.headerDate
        headerCell.hourHeaderlabel.text = StructS.headerHours + " " + "-"
        headerCell.totalHoursHeaderlabel.text = String("\(StructS.numberHours) HOURS")
        headerCell.priceHeaderlabel.text = String("£\(StructS.price)")
        
        headerCell.backgroundColor =  UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        
        print("header selected")
        
        return headerCell
        
    }
   
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    
    

    
    @IBAction func nextButton(sender: AnyObject) {

    }

}

