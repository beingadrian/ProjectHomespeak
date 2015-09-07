//
//  FitnessReportViewController.swift
//  ProjectHomespeak
//
//  Created by Adrian Wisaksana on 9/6/15.
//  Copyright (c) 2015 BeingAdrian. All rights reserved.
//

import UIKit

class FitnessReportViewController: UIViewController {

    // MARK: -
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get healthKit data
        let begginingOfDay = NSDate().beginningOfDay()
        
        HealthHelper.getTotalStepsSinceDate(begginingOfDay) {
            (totalSteps, error) in
            
            if (error != nil) {
                println(error?.description)
            }
            
            if let totalSteps = totalSteps {
                self.stepsLabel.text = String(totalSteps)
            } else {
                self.stepsLabel.text = "0"
            }
        }
        
        HealthHelper.getTotalDistanceSinceDate(begginingOfDay) {
            (totalDistance, error) in
            
            if (error != nil) {
                println(error?.description)
            }
            
            if let totalDistance = totalDistance {
                self.distanceLabel.text = String(totalDistance)
            } else {
                self.distanceLabel.text = "0"
            }
        }
        
        // TODO: - Get total calories burned
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}
