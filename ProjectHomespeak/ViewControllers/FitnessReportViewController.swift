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
    @IBOutlet weak var messageLabel: UILabel!
    
    
    // stored data
    var lastTotalSteps = 0 {
        didSet {
            HealthHelper.lastTotalSteps = lastTotalSteps
            stepsLabel.text = "\(HealthHelper.lastTotalSteps)"
        }
    }
    var lastTotalDistance: Double = 0 {
        didSet {
            HealthHelper.lastTotalDistance = lastTotalDistance
            distanceLabel.text = "\(HealthHelper.lastTotalDistance)km"
        }
    }
    var lastTotalActiveCalories: Double = 0 {
        didSet {
            HealthHelper.lastTotalActiveCalories = lastTotalActiveCalories
            caloriesLabel.text = "\(HealthHelper.lastTotalActiveCalories)kcal"
        }
    }
    
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initial text labels
        stepsLabel.text = "\(HealthHelper.lastTotalSteps)"
        distanceLabel.text = "\(HealthHelper.lastTotalDistance)km"
        caloriesLabel.text = "\(HealthHelper.lastTotalActiveCalories)kcal"
        
        
        if (HealthHelper.healthKitIsAuthorized) {
            
            // message label
            messageLabel.text = "Loading data..."
            
            // get healthKit data
            let begginingOfDay = NSDate().beginningOfDay()
            
            // queries
            HealthHelper.getTotalStepsSinceDate(begginingOfDay) {
                (totalSteps, error) in
                
                if (error != nil) {
                    println(error?.description)
                }
                
                if let totalSteps = totalSteps {
                    self.lastTotalSteps = totalSteps
                }
                
                HealthHelper.getTotalDistanceSinceDate(begginingOfDay) {
                    (totalDistance, error) in
                    
                    if (error != nil) {
                        println(error?.description)
                    }
                    
                    if let totalDistance = totalDistance {
                        // total distance in meters
                        let distanceInMeters = Double(totalDistance) / 1000
                        let roundedDistance = round(distanceInMeters * 10) / 10
                        self.lastTotalDistance = roundedDistance
                    }
                    
                    HealthHelper.getTotalActiveCaloriesBurnedSinceDate(begginingOfDay) {
                        (totalActiveCaloriesBurned, error) in
                        
                        if (error != nil) {
                            println(error?.description)
                        }
                        
                        if let totalActiveCaloriesBurned = totalActiveCaloriesBurned {
                            let kilocalories = Double(totalActiveCaloriesBurned) / 1000
                            let roundedKiloCalories = round(kilocalories * 10) / 10
                            self.lastTotalActiveCalories = roundedKiloCalories
                        }
                        
                        // hide message label
                        self.messageLabel.alpha = 0
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}
