//
//  FitnessReportViewController.swift
//  ProjectHomespeak
//
//  Created by Adrian Wisaksana on 9/6/15.
//  Copyright (c) 2015 BeingAdrian. All rights reserved.
//

import UIKit


class FitnessReportViewController: UIViewController {

    // MARK: - Connections
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var authorizationWarningLabel: UILabel!
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
    @IBOutlet weak var blurViewMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get healthKit data
        let begginingOfDay = NSDate().beginningOfDay()
        
        if (HealthHelper.healthKitIsAuthorized) {
            
            // set blur view message label
            blurViewMessageLabel.text = "Loading HealthKit data..."
            
            // queries
            
            HealthHelper.getTotalStepsSinceDate(begginingOfDay) {
                (totalSteps, error) in
                
                if (error != nil) {
                    println(error?.description)
                }
                
                if let totalSteps = totalSteps {
                    self.stepsLabel.text = String(totalSteps)
                }
                
            }
            
            HealthHelper.getTotalDistanceSinceDate(begginingOfDay) {
                (totalDistance, error) in
                
                if (error != nil) {
                    println(error?.description)
                }
                
                if let totalDistance = totalDistance {
                    self.distanceLabel.text = String(totalDistance/1000) + "km"
                }
                
            }
            
            HealthHelper.getTotalActiveCaloriesBurnedSinceDate(begginingOfDay) {
                (totalActiveCaloriesBurned, error) in
                
                if (error != nil) {
                    println(error?.description)
                }
                
                if let totalActiveCaloriesBurned = totalActiveCaloriesBurned {
                    self.caloriesLabel.text = String(totalActiveCaloriesBurned) + "kcal"
                    self.fadeOutBlurView()
                } else {
                    self.fadeOutBlurView()
                }
                
            }
            
            // hide warning
            authorizationWarningLabel.alpha = 0
            
            
        } else {
            
            // set blur view message label
            blurViewMessageLabel.text = "HealthKit data unavailable"
            
            // set label default
            stepsLabel.text = "0"
            distanceLabel.text = "0" + "km"
            caloriesLabel.text = "0" + "kcal"
            
            // show warning
            authorizationWarningLabel.alpha = 1
            
        }
        
    }
    
    func fadeOutBlurView() {
        
        UIView.animateWithDuration(1, animations: {
            self.blurEffectView.alpha = 0
            }, completion: {
                (success) in
                self.blurEffectView.removeFromSuperview()
        })
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}
