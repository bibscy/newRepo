//
//  VC1.swift
//  
//
//  Created by Bogdan Barbulescu on 13/08/2016.
//
//

import UIKit

class VC1: UIViewController {

    func random9DigitString() -> Int {
        let min: UInt32 = 100_000_000
        let max: UInt32 = 999_999_999
        let i = min + arc4random_uniform(max - min + 1)
        return Int(i)
    }
       override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        print(random9DigitString())
    }



}
