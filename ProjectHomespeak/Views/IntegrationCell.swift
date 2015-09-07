//
//  IntegrationCell.swift
//  ProjectHomespeak
//
//  Created by Adrian Wisaksana on 9/6/15.
//  Copyright (c) 2015 BeingAdrian. All rights reserved.
//

import UIKit

class IntegrationCell: UITableViewCell {

    // MARK: - Code connections
    
    @IBOutlet weak var integrationToggleButton: UIButton!
    @IBOutlet weak var integrationLabel: UILabel!
    
    // MARK: - Properties
    var index = 0
    
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func integrationButtonPressed(sender: UIButton) {
        
        // get parent cell
        let selectedIntegrationCell = (sender.superview?.superview) as! IntegrationCell
        let integrationIndex = selectedIntegrationCell.index
        
        // toggling mechanism
        Manager.toggleIntegrationWithIndex(integrationIndex, button: sender)
        
    }
    

}
