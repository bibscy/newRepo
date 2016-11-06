//
//  CustomerHeader_NinethViewController.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 28/08/2016.
//  Copyright © 2016 brev. All rights reserved.
//

import UIKit

class CustomerHeader_NinethViewController: UITableViewCell {

    
    @IBOutlet weak var dateHeaderlabel: UILabel!
    
    @IBOutlet weak var hourHeaderlabel: UILabel!
    
    
    @IBOutlet weak var totalHoursHeaderlabel: UILabel!
    
    @IBOutlet weak var priceHeaderlabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
