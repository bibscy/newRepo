//
//  FullData.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 07/08/2016.
//  Copyright © 2016 brev. All rights reserved.
//

import Foundation

// save info from all ViewControllers in this structure
struct FullData {
   static  var finalBookingAmount:String!
   static  var finalBookingNumber:String!
   static  var finalPostCode:String!
   static  var finalSelectedBathRow:Int!
   static  var finalSelectedBedRow:Int!
   static  var finalDateAndTime:String!
   static  var finalFrequencyName:String!
   static  var finalFrequecyAmount:Int!
    
    static var insideCabinets:Bool!
    static var insideFridge:Bool!
    static var insideOven:Bool!
    static var laundryWash:Bool!
    static var interiorWindows:Bool! 
    
    static var finalSuppliesName:String!
    static  var finalSuppliesAmount:Int! = 0
    static var finalfullName:String!
    static  var finalflatNumber:String!
    static var finalstreetAddress:String!
    static  var finalphoneNumber:String!
    static var finalemailAddress:String!

}


// save the userID for the current logged in user
struct StructS {
    
    static var myUid:String!
    static var myBooking:String!
    static var indexPath:NSIndexPath!
    static var totalExtras = 0 // we will store the total from NinethViewController (if a row selected)
    static let rate1:Int = 14  // applied for 1 bed
    static let rate2:Int = 12  // Once
    static let rate3:Int = 11  // Every - week, 2 weeks, 4 weeks
    static let rate4:Int = 18  // End of Tenancy
    
    
   static var numberHours:Int = 0
   static var minHours:Int = 2
   static var price:Int = 0
    
    static var selectedBed:Int!
    static var selectedBath:Int!
    
    static var headerDate:String!
    static var headerHours:String! // the number of hours calculated by func calculatedTotal()
    static var extrasHours:Double! = 0.0

}

struct CustomText {
    static var myAttribute = [
        NSForegroundColorAttributeName: UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0),
        NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 31.0)!
        
      
    ]
  
}


struct ItemSelected {
    var name:String // name of the row
    var selected:Bool // whether is selected or not
    var amount: Int // value of the item
    var time:Double
}

var extrasSelected = [
    ItemSelected(name:"Inside Cabinets",selected: false, amount: 5,time:0.5),
    ItemSelected(name:"Inside Fridge",selected: false, amount: 5,time:0.5),
    ItemSelected(name:"Inside Oven",selected: false, amount: 5,time:0.5),
    ItemSelected(name:"Laundry wash & dry",selected: false, amount: 10,time: 1.0),
    ItemSelected(name:"Interior Windows", selected: false, amount: 5,time:0.5)
]



// FrequencyAmount structure holds the logic for calculating the total of each type of cleaning depending on the selectedBed, selectedBath, frequency and rate.
struct FrequencyAmount {
    
     static func calculateTotal() {
        
// For each amount of selectedBed a case is created. case 0,1 handles all situations when selectedBed holds a value of 0 or 1
        
        switch StructS.selectedBed {
           
case 0,1:
    
            
            if StructS.selectedBed <= 1 && StructS.selectedBath < 5 && StructS.indexPath.row == 3 {
                  StructS.numberHours = StructS.minHours
                     StructS.price = StructS.numberHours * StructS.rate1
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
          } else if StructS.selectedBed <= 1 && StructS.selectedBath < 5 && StructS.indexPath.row == 4 {
                       StructS.numberHours = 5
                            StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
       } else if StructS.selectedBed <= 1 && StructS.selectedBath < 5 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4  {
                   StructS.numberHours = StructS.minHours
                       StructS.price = StructS.numberHours * StructS.rate3
                
                 print("NumberBeds \(StructS.selectedBed)")
                 print("NumberHours \(StructS.numberHours)")
                 print("Price \(StructS.price)")
          
                // 5 baths or more
            } else if StructS.selectedBed <= 1 && StructS.selectedBath >= 5 && StructS.indexPath.row == 3 {
                     StructS.numberHours = 5
                        StructS.price = StructS.numberHours * StructS.rate2
                
            } else if StructS.selectedBed <= 1 && StructS.selectedBath >= 5 && StructS.indexPath.row == 4 {
                 StructS.numberHours = 6
                    StructS.price = StructS.numberHours * StructS.rate4
                
            }  else if StructS.selectedBed <= 1 && StructS.selectedBath >= 5 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4  {
                   StructS.numberHours = 5
                      StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
            }
            
            
case 2:
            
     if StructS.selectedBed == 2 && StructS.selectedBath >= 0 && StructS.indexPath.row == 3 {
            StructS.numberHours = StructS.minHours + 1
               StructS.price = StructS.numberHours * StructS.rate2
        
        print("NumberBeds \(StructS.selectedBed)")
        print("NumberHours \(StructS.numberHours)")
        print("Price \(StructS.price)")
        
        
    } else if StructS.selectedBed == 2 && StructS.selectedBath >= 0 && StructS.indexPath.row == 4 {
             StructS.numberHours = 7
                StructS.price = StructS.numberHours * StructS.rate4
        
        print("NumberBeds \(StructS.selectedBed)")
        print("NumberHours \(StructS.numberHours)")
        print("Price \(StructS.price)")
        
     } else if StructS.selectedBed == 2 && StructS.selectedBath >= 0 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                 StructS.numberHours = StructS.minHours + 1
                    StructS.price = StructS.numberHours * StructS.rate3
        
        print("NumberBeds \(StructS.selectedBed)")
        print("NumberHours \(StructS.numberHours)")
        print("Price \(StructS.price)")
     }
            
case 3:
           
        if StructS.selectedBed == 3 && StructS.selectedBath <= 2 && StructS.indexPath.row == 3 {
                StructS.numberHours = StructS.minHours + 1
                  StructS.price = StructS.numberHours * StructS.rate2
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
   } else if StructS.selectedBed == 3 && StructS.selectedBath <= 2 && StructS.indexPath.row == 4 {
            StructS.numberHours = 8
              StructS.price = StructS.numberHours * StructS.rate4
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
 }  else if StructS.selectedBed == 3 && StructS.selectedBath <= 2 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
              StructS.numberHours = StructS.minHours + 1
                StructS.price = StructS.numberHours * StructS.rate3
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
            // if selectedBath >= 3 <= 6
} else if StructS.selectedBed == 3 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row == 3 {
            StructS.numberHours = StructS.selectedBed + 1
              StructS.price = StructS.numberHours * StructS.rate2
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
        } else if StructS.selectedBed == 3 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row == 4 {
                StructS.numberHours = 9
                    StructS.price = StructS.numberHours * StructS.rate4
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
   } else if StructS.selectedBed == 3 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
               StructS.numberHours = StructS.minHours + 1
                   StructS.price = StructS.numberHours * StructS.rate3
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
             // if selectedBath >= 7 <= 8
 } else if StructS.selectedBed == 3 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row == 3 {
             StructS.numberHours = StructS.selectedBed + 2
               StructS.price = StructS.numberHours * StructS.rate2
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
        } else if StructS.selectedBed == 3 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row == 4 {
              StructS.numberHours = 10
                 StructS.price = StructS.numberHours * StructS.rate4
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
        } else if StructS.selectedBed == 3 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
             StructS.numberHours = StructS.selectedBed + 2
                 StructS.price = StructS.numberHours * StructS.rate3
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
            
            
            
            // if selectedBath >= 9 <= 10
        } else if StructS.selectedBed == 3 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row == 3 {
              StructS.numberHours = StructS.selectedBed + 3
                  StructS.price = StructS.numberHours * StructS.rate2
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
        } else if StructS.selectedBed == 3 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row == 4 {
               StructS.numberHours = 11
                   StructS.price = StructS.numberHours * StructS.rate4
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
        } else if StructS.selectedBed == 3 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                StructS.numberHours = StructS.selectedBed + 3
                     StructS.price = StructS.numberHours * StructS.rate3
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            }
            
case 4:
            
            if StructS.selectedBed == 4 && StructS.selectedBath <= 2 && StructS.indexPath.row == 3 {
                 StructS.numberHours = StructS.minHours + 2
                      StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 4 && StructS.selectedBath <= 2 && StructS.indexPath.row == 4 {
                  StructS.numberHours = 9
                        StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            }  else if StructS.selectedBed == 4 && StructS.selectedBath <= 2 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                  StructS.numberHours = StructS.minHours + 2
                      StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
                // if selectedBath >= 3 <= 6
            } else if StructS.selectedBed == 4 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row == 3 {
                  StructS.numberHours = StructS.selectedBed + 1  // no need to edit
                        StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 4 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row == 4 {
                    StructS.numberHours = 10
                       StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 4 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                  StructS.numberHours = StructS.minHours + 2
                       StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
                // if selectedBath >= 7 <= 8
            } else if StructS.selectedBed == 4 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row == 3 {
                  StructS.numberHours = StructS.selectedBed + 3
                         StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 4 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row == 4 {
                   StructS.numberHours = 11
                          StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 4 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                    StructS.numberHours = StructS.selectedBed + 3
                          StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
                
                
                
                // if selectedBath >= 9 <= 10
            } else if StructS.selectedBed == 4 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row == 3 {
                  StructS.numberHours = StructS.selectedBed + 4
                        StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 4 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row == 4 {
                   StructS.numberHours = 12
                         StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 4 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                   StructS.numberHours = StructS.selectedBed + 4
                        StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
            }

        case 5:
            
            if StructS.selectedBed == 5 && StructS.selectedBath <= 2 && StructS.indexPath.row == 3 {
                  StructS.numberHours = StructS.minHours + 3
                       StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 5 && StructS.selectedBath <= 2 && StructS.indexPath.row == 4 {
                   StructS.numberHours = 10
                        StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            }  else if StructS.selectedBed == 5 && StructS.selectedBath <= 2 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                   StructS.numberHours = StructS.minHours + 3
                        StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
                // if selectedBath >= 3 <= 6
            } else if StructS.selectedBed == 5 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row == 3 {
                     StructS.numberHours = StructS.selectedBed + 1  // no need to edit
                         StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 5 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row == 4 {
                      StructS.numberHours = 11
                          StructS.price = StructS.numberHours * StructS.rate4
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 5 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                       StructS.numberHours = StructS.minHours + 3
                            StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
                // if selectedBath >= 7 <= 8
            } else if StructS.selectedBed == 5 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row == 3 {
                       StructS.numberHours = StructS.selectedBed + 4
                           StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 5 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row == 4 {
                          StructS.numberHours = 12
                              StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 5 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                        StructS.numberHours = StructS.selectedBed + 4
                             StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
                
                
                
                // if selectedBath >= 9 <= 10
            } else if StructS.selectedBed == 5 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row == 3 {
                     StructS.numberHours = StructS.selectedBed + 5
                           StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 5 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row == 4 {
                       StructS.numberHours = 13
                           StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 5 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                      StructS.numberHours = StructS.selectedBed + 5
                          StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
            }

case 6:
        
     if StructS.selectedBed == 6 && StructS.selectedBath <= 2 && StructS.indexPath.row == 3 {
                   StructS.numberHours = StructS.minHours + 4
                        StructS.price = StructS.numberHours * StructS.rate2
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
        } else if StructS.selectedBed == 6 && StructS.selectedBath <= 2 && StructS.indexPath.row == 4 {
                 StructS.numberHours = 11
                      StructS.price = StructS.numberHours * StructS.rate4
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
    }  else if StructS.selectedBed == 6 && StructS.selectedBath <= 2 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                  StructS.numberHours = StructS.minHours + 4
                      StructS.price = StructS.numberHours * StructS.rate3
            
              print("NumberBeds \(StructS.selectedBed)")
              print("NumberHours \(StructS.numberHours)")
              print("Price \(StructS.price)")
            
            // if selectedBath >= 3 <= 6
        } else if StructS.selectedBed == 6 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row == 3 {
                    StructS.numberHours = StructS.selectedBed + 1  // no need to edit
                         StructS.price = StructS.numberHours * StructS.rate2
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
        } else if StructS.selectedBed == 6 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row == 4 {
                   StructS.numberHours = 12
                       StructS.price = StructS.numberHours * StructS.rate4
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
        } else if StructS.selectedBed == 6 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                     StructS.numberHours = StructS.minHours + 4
                          StructS.price = StructS.numberHours * StructS.rate3
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
            // if selectedBath >= 7 <= 8
        } else if StructS.selectedBed == 6 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row == 3 {
                     StructS.numberHours = StructS.selectedBed + 5
                        StructS.price = StructS.numberHours * StructS.rate2
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
        } else if StructS.selectedBed == 6 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row == 4 {
                     StructS.numberHours = 13
                        StructS.price = StructS.numberHours * StructS.rate4
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
        } else if StructS.selectedBed == 6 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                      StructS.numberHours = StructS.selectedBed + 5
                           StructS.price = StructS.numberHours * StructS.rate3
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
            
            
            
            // if selectedBath >= 9 <= 10
        } else if StructS.selectedBed == 6 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row == 3 {
               StructS.numberHours = StructS.selectedBed + 6
                      StructS.price = StructS.numberHours * StructS.rate2
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
        } else if StructS.selectedBed == 6 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row == 4 {
                     StructS.numberHours = 14
                          StructS.price = StructS.numberHours * StructS.rate4
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            
        } else if StructS.selectedBed == 6 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                     StructS.numberHours = StructS.selectedBed + 6
                         StructS.price = StructS.numberHours * StructS.rate3
            
            print("NumberBeds \(StructS.selectedBed)")
            print("NumberHours \(StructS.numberHours)")
            print("Price \(StructS.price)")
            }
            
case 7:
            
            if StructS.selectedBed == 7 && StructS.selectedBath <= 2 && StructS.indexPath.row == 3 {
                    StructS.numberHours = StructS.minHours + 5
                            StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 7 && StructS.selectedBath <= 2 && StructS.indexPath.row == 4 {
                       StructS.numberHours = 12
                            StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            }  else if StructS.selectedBed == 7 && StructS.selectedBath <= 2 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                       StructS.numberHours = StructS.minHours + 5
                             StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
                // if selectedBath >= 3 <= 6
            } else if StructS.selectedBed == 7 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row == 3 {
                    StructS.numberHours = StructS.selectedBed + 1  // no need to edit
                           StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 7 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row == 4 {
                   StructS.numberHours = 13
                          StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 7 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                      StructS.numberHours = StructS.minHours + 5
                            StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
                // if selectedBath >= 7 <= 8
            } else if StructS.selectedBed == 7 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row == 3 {
                      StructS.numberHours = StructS.selectedBed + 6
                          StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 7 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row == 4 {
                   StructS.numberHours = 14
                          StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 7 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                    StructS.numberHours = StructS.selectedBed + 6
                           StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
                
                // if selectedBath >= 9 <= 10
            } else if StructS.selectedBed == 7 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row == 3 {
                     StructS.numberHours = StructS.selectedBed + 7
                          StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 7 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row == 4 {
                    StructS.numberHours = 15
                        StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 7 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                    StructS.numberHours = StructS.selectedBed + 7
                          StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
            }

        case 8:
            
            if StructS.selectedBed == 8 && StructS.selectedBath <= 2 && StructS.indexPath.row == 3 {
                   StructS.numberHours = StructS.minHours + 6
                          StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 8 && StructS.selectedBath <= 2 && StructS.indexPath.row == 4 {
                StructS.numberHours = 13
                    StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            }  else if StructS.selectedBed == 8 && StructS.selectedBath <= 2 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                  StructS.numberHours = StructS.minHours + 6
                       StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
                // if selectedBath >= 3 <= 6
            } else if StructS.selectedBed == 8 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row == 3 {
                   StructS.numberHours = StructS.selectedBed + 1  // no need to edit
                       StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 8 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row == 4 {
                   StructS.numberHours = 14
                       StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 8 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                      StructS.numberHours = StructS.minHours + 6
                         StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
                // if selectedBath >= 8 <= 8
            } else if StructS.selectedBed == 8 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row == 3 {
                       StructS.numberHours = StructS.selectedBed + 7
                           StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 8 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row == 4 {
                       StructS.numberHours = 15
                           StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 8 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                      StructS.numberHours = StructS.selectedBed + 7
                          StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
                
                
                
                // if selectedBath >= 9 <= 10
            } else if StructS.selectedBed == 8 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row == 3 {
                        StructS.numberHours = StructS.selectedBed + 8
                              StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 8 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row == 4 {
                       StructS.numberHours = 16
                            StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 8 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                       StructS.numberHours = StructS.selectedBed + 8
                               StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
            }
        
case 9:
            
            if StructS.selectedBed == 9 && StructS.selectedBath <= 2 && StructS.indexPath.row == 3 {
                      StructS.numberHours = StructS.minHours + 7
                           StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 9 && StructS.selectedBath <= 2 && StructS.indexPath.row == 4 {
                      StructS.numberHours = 14
                          StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            }  else if StructS.selectedBed == 9 && StructS.selectedBath <= 2 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                        StructS.numberHours = StructS.minHours + 7
                            StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
                // if selectedBath >= 3 <= 6
            } else if StructS.selectedBed == 9 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row == 3 {
                    StructS.numberHours = StructS.selectedBed + 1  // no need to edit
                             StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 9 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row == 4 {
                   StructS.numberHours = 15
                         StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 9 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                      StructS.numberHours = StructS.minHours + 7
                         StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
                // if selectedBath >= 8 <= 8
            } else if StructS.selectedBed == 9 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row == 3 {
                       StructS.numberHours = StructS.selectedBed + 8
                           StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 9 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row == 4 {
                       StructS.numberHours = 16
                            StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 9 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                      StructS.numberHours = StructS.selectedBed + 8
                         StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
                
                
                
                // if selectedBath >= 9 <= 10
            } else if StructS.selectedBed == 9 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row == 3 {
                       StructS.numberHours = StructS.selectedBed + 9
                          StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 9 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row == 4 {
                    StructS.numberHours = 17
                         StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 9 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                     StructS.numberHours = StructS.selectedBed + 9
                           StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
            }

    
        case 10:
            
            if StructS.selectedBed == 10 && StructS.selectedBath <= 2 && StructS.indexPath.row == 3 {
                    StructS.numberHours = StructS.minHours + 8
                           StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 10 && StructS.selectedBath <= 2 && StructS.indexPath.row == 4 {
                       StructS.numberHours = 15
                           StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            }  else if StructS.selectedBed == 10 && StructS.selectedBath <= 2 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                       StructS.numberHours = StructS.minHours + 8
                             StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
                // if selectedBath >= 3 <= 6
            } else if StructS.selectedBed == 10 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row == 3 {
                       StructS.numberHours = StructS.selectedBed + 1  // no need to edit
                             StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 10 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row == 4 {
                        StructS.numberHours = 16
                             StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 10 && StructS.selectedBath >= 3 && StructS.selectedBath <= 6 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                      StructS.numberHours = StructS.minHours + 8
                           StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
                // if selectedBath >= 8 <= 8
            } else if StructS.selectedBed == 10 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row == 3 {
                        StructS.numberHours = StructS.selectedBed + 9
                            StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 10 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row == 4 {
                       StructS.numberHours = 17
                            StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 10 && StructS.selectedBath >= 7 && StructS.selectedBath <= 8 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                       StructS.numberHours = StructS.selectedBed + 9
                             StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
                
                
                
                // if selectedBath >= 9 <= 10
            } else if StructS.selectedBed == 10 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row == 3 {
                       StructS.numberHours = StructS.selectedBed + 10
                           StructS.price = StructS.numberHours * StructS.rate2
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 10 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row == 4 {
                       StructS.numberHours = 18
                           StructS.price = StructS.numberHours * StructS.rate4
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
                
            } else if StructS.selectedBed == 10 && StructS.selectedBath >= 9 && StructS.selectedBath <= 10 && StructS.indexPath.row != 3 && StructS.indexPath.row != 4 {
                        StructS.numberHours = StructS.selectedBed + 10
                            StructS.price = StructS.numberHours * StructS.rate3
                
                print("NumberBeds \(StructS.selectedBed)")
                print("NumberHours \(StructS.numberHours)")
                print("Price \(StructS.price)")
            }


        default:
            print("bed ERROR \(StructS.selectedBed)")
        print("row ERROR \(StructS.indexPath.row)")
        }
    } // end of calculateTotal()
    

}


