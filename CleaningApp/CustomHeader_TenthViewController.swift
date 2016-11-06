//
//  CustomHeader_TenthViewController.swift
//  CleaningApp
//
//  Created by Bogdan Barbulescu on 29/08/2016.
//  Copyright © 2016 brev. All rights reserved.
//

import UIKit

class CustomHeader_TenthViewController: UITableViewCell {

    
    @IBOutlet weak var dateHeaderlabel: UILabel!
    
    
    @IBOutlet weak var hourHeaderlabel: UILabel!
    
    
    @IBOutlet weak var totalHoursHeaderlabel: UILabel!
    
    
    @IBOutlet weak var priceHeaderlabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
