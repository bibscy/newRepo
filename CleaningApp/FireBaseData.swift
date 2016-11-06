//
//  FireBaseData.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 08/08/2016.
//  Copyright © 2016 brev. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

struct FireBaseData {
    
  // Create our Firebase Data model
    // get arbitrary data
    
    var BookingAmount:String!
    var BookingNumber:String!
    var Key:String!
    var PostCode:String!
    var SelectedBathRow:Int!
    var SelectedBedRow:Int!
    var DateAndTime:String!
    var FrequencyName:String!
    var FrequecyAmount:Int!
    
     var insideCabinets:Bool!
     var insideFridge:Bool!
     var insideOven:Bool!
     var laundryWash:Bool!
     var interiorWindows:Bool!
    
    var SuppliesName:String!
    var SuppliesAmount:Int!
    var FullName:String!
    var FlatNumber:String!
    var StreetAddress:String!
    var PhoneNumber:String!
    var EmailAddress:String!
   
    let Ref:FIRDatabaseReference?
    
    init(
  BookingAmount:String,
    BookingNumber:String,
      PostCode:String,
       SelectedBathRow:Int,
         SelectedBedRow:Int,
            DateAndTime:String,
            FrequencyName:String,
              FrequecyAmount:Int,
              
               insideCabinets:Bool,
               insideFridge:Bool,
               insideOven:Bool,
               laundryWash:Bool,
               interiorWindows:Bool,
    
                FullName:String,
                  SuppliesName:String,
                   SuppliesAmount:Int,
                    FlatNumber:String,
                       StreetAddress:String,
                        PhoneNumber:String,
                         EmailAddress:String,
                            Key:String = ""
        ) {
 self.BookingAmount = BookingAmount
   self.BookingNumber = BookingNumber
       self.Key = Key
        self.PostCode = PostCode
            self.SelectedBathRow = SelectedBathRow
                self.SelectedBedRow = SelectedBedRow
                    self.DateAndTime = DateAndTime
                        self.FrequencyName = FrequencyName
                            self.FrequecyAmount = FrequecyAmount
        
        self.insideCabinets = insideCabinets
        self.insideFridge = insideFridge
        self.insideOven = insideOven
        self.laundryWash = laundryWash
        self.interiorWindows = interiorWindows
        
            self.FullName = FullName
                self.SuppliesName = SuppliesName
                    self.SuppliesAmount = SuppliesAmount
                        self.FlatNumber = FlatNumber
    
            self.StreetAddress = StreetAddress
                self.PhoneNumber = PhoneNumber
                    self.EmailAddress = EmailAddress
                    self.Ref = nil

    }
   // Content
    // receive data from our firebase database
    
    init(snapshot:FIRDataSnapshot){
        
        if let BookingAmountContent = snapshot.value!["BookingAmount"] as? String {
            BookingAmount = BookingAmountContent
        }
        
        if let BookingNumberContent = snapshot.value!["BookingNumber"] as? String {
            BookingNumber = BookingNumberContent
        }
        
        Key = snapshot.key
        Ref = snapshot.ref
        
        if let PostCodeContent = snapshot.value!["PostCode"] as? String {
            PostCode = PostCodeContent
        }
        
        if let SelectedBathRowContent = snapshot.value!["SelectedBathRow"] as? Int {
                SelectedBathRow = SelectedBathRowContent
        }
        
        if let SelectedBedRowContent = snapshot.value!["SelectedBedRow"] as? Int {
                        SelectedBedRow = SelectedBedRowContent
        }
      
        if let DateAndTimeContent = snapshot.value!["DateAndTime"] as? String {
            DateAndTime = DateAndTimeContent
        }
        
        if let FrequencyNameContent = snapshot.value!["FrequencyName"] as? String {
            FrequencyName = FrequencyNameContent
        }
        
        if let FrequecyAmountContent = snapshot.value!["FrequecyAmount"] as? Int {
            FrequecyAmount = FrequecyAmountContent
        }
        
        if let insideCabinetsContent = snapshot.value!["insideCabinets"] as? Bool {
            insideCabinets = insideCabinetsContent
        }
        
        if let insideFridgeContent = snapshot.value!["insideFridge"] as? Bool {
            insideFridge = insideFridgeContent
        }
      
        if let insideOvenContent = snapshot.value!["insideOven"] as? Bool {
            insideOven = insideOvenContent
        }
       
        if let laundryWashContent = snapshot.value!["laundryWash"] as? Bool {
            laundryWash = laundryWashContent
        }
       
        if let interiorWindowsContent = snapshot.value!["interiorWindows"] as? Bool {
            interiorWindows = interiorWindowsContent
        }
       
        
        if let FullNameContent = snapshot.value!["FullName"] as? String {
            FullName = FullNameContent
        }
        
        if let SuppliesNameContent = snapshot.value!["SuppliesName"] as? String {
            SuppliesName = SuppliesNameContent
        }
        
        if let SuppliesAmountContent = snapshot.value!["SuppliesAmount"] as? Int {
            SuppliesAmount = SuppliesAmountContent
        }
        
        if let FlatNumberContent = snapshot.value!["FlatNumber"] as? String {
            FlatNumber = FlatNumberContent
        }
        
        if let StreetAddressContent = snapshot.value!["StreetAddress"] as? String {
            StreetAddress = StreetAddressContent
        }
        
        if let PhoneNumberContent = snapshot.value!["PhoneNumber"] as? String {
            PhoneNumber = PhoneNumberContent
        }
        
        if let EmailAddressContent = snapshot.value!["EmailAddress"] as? String {
            EmailAddress = EmailAddressContent
        }
    }

    func toAnyObject() -> AnyObject {
        return [
                "BookingAmount":BookingAmount,
                "BookingNumber":BookingNumber,
                "PostCode":PostCode,
                "SelectedBathRow":SelectedBathRow,
                "SelectedBedRow":SelectedBedRow,
                "DateAndTime":DateAndTime,
                "FrequencyName":FrequencyName,
                "FrequecyAmount":FrequecyAmount,
        
         "insideCabinets": insideCabinets,
         "insideFridge": insideFridge,
         "insideOven": insideOven,
         "laundryWash": laundryWash,
         "interiorWindows": interiorWindows,
        
        "FullName":FullName,
        "SuppliesName":SuppliesName,
        "SuppliesAmount":SuppliesAmount,
        "FlatNumber":FlatNumber,
        "StreetAddress":StreetAddress,
        "PhoneNumber":PhoneNumber,
        "EmailAddress":EmailAddress
        ]
    }
}


