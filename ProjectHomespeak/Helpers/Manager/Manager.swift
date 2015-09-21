//
//  Manager.swift
//  ProjectHomespeak
//
//  Created by Adrian Wisaksana on 9/6/15.
//  Copyright (c) 2015 BeingAdrian. All rights reserved.
//

import Foundation
import UIKit


class Manager {
    
    // NSUserDefaults
    static let defaults = NSUserDefaults.standardUserDefaults()
    
    // geofencing setup
    static var userIsSetup = false
    
    // integrations
    static let integrations = ["Fitness report", "Auto-music", "Stocks report", "Planner"]
    static var activeIntegrationsArray: [Bool] = defaults.arrayForKey("activeIntegrationsArray") as? [Bool] ?? [false, false, false, false] {
        didSet {
            defaults.setValue(activeIntegrationsArray, forKey: "activeIntegrationsArray")
        }
    }
    
    // integration cell properties
    static let integrationRowHeight: CGFloat = 110
    
    static let integrationImagesNormal = ["Health", "Music", "Stocks", "Calendar"]
    static var integrationImagesSelected: [String] = {
    
        var fileNamesArray: [String] = []
        
        for fileName in integrationImagesNormal {
            let selectedFileName = fileName + " - tinted"
            fileNamesArray.append(selectedFileName)
        }
        
        return fileNamesArray
        
    }()
    
    
    // TODO: - Full report (error handling)
    
    static func getFullReportData(completionBlock: (errors: [Int: Bool]) -> Void) {
        
        // errors
        var reportErrors: [Int: Bool] = [
            0: false,
            1: false,
            2: false,
            3: false
        ]
        
        // get health kit data
        if (activeIntegrationsArray[0]) {
            
            HealthHelper.getHealthDataSet() {
                (errors) in
                
                if (errors.count != 0) {
                    reportErrors[0] = true
                    println(errors)
                }
                
            }
            
        }
        
        // auto-music
        if (activeIntegrationsArray[1]) {
            
            // code
            
        }
        
        // stock report
        if (activeIntegrationsArray[2]) {
            
            // code
            
        }
        
        // planner
        if (activeIntegrationsArray[3]) {
            
            // code{
            
        }
        
        completionBlock(errors: reportErrors)

    }
    
    
    // MARK: - Integration toggle
    
    static func toggleIntegrationWithIndex(index: Int, button: UIButton) {
        
        if (button.selected == true) {
            // toggle off
            activeIntegrationsArray[index] = false
            checkActiveIntegrationsWithButton(button)
            button.selected = false
        } else {
            // toggle on
            button.selected = true
            activeIntegrationsArray[index] = true
            checkActiveIntegrationsWithButton(button)
        }
        
    }
    
    // run active integrations
    static func checkActiveIntegrationsWithButton(button: UIButton) {
        
        for index in 0...3 {
            
            if activeIntegrationsArray[index] {
                
                println("\(index) is active")
                
            }
            
        }
        
    }
    
    
}