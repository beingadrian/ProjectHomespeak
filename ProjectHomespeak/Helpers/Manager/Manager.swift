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
    
    // integrations
    static let integrations = ["Fitness report", "Auto-music", "Stocks report", "Planner"]
    static var activeIntegrationDict: [Int: Bool] = [0: false, 1: false, 2: false, 3: false]
    
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
    
    
    // TODO: - Full report
    
    static func getFullReportData(completionBlock: (errors: [Int: Bool]) -> Void) {
        
        // errors
        var reportErrors: [Int: Bool] = [
            0: false,
            1: false,
            2: false,
            3: false
        ]
        
        // get health kit data
        if (activeIntegrationDict[0]!) {
            
            HealthHelper.getHealthDataSet() {
                (errors) in
                
                if (errors.count != 0) {
                    reportErrors[0] = true
                    println(errors)
                }
                
            }
            
        }
        
        completionBlock(errors: reportErrors)

    }
    
    
    // MARK: - Integration toggle
    
    static func toggleIntegrationWithIndex(index: Int, button: UIButton) {
        
        if (button.selected == true) {
            // toggle off
            activeIntegrationDict[index] = false
            checkActiveIntegrationsWithButton(button)
            button.selected = false
        } else {
            // toggle on
            button.selected = true
            activeIntegrationDict[index] = true
            checkActiveIntegrationsWithButton(button)
        }
        
    }
    
    // run active integrations
    static func checkActiveIntegrationsWithButton(button: UIButton) {
        
        for (index, isActive) in activeIntegrationDict {
            
            if (isActive) {
                
                switch (index) {
                case 0:
                    // Fitness report
                    println("\(index) is active")
                    // TODO: if healthkit not authorized disable toggle
                case 1:
                    // Auto-music
                    println("\(index) is active")
                case 2:
                    // Stock report
                    println("\(index) is active")
                case 3:
                    // Planner
                    println("\(index) is active")
                default:
                    break
                }
                
            }
            
        }
        
    }
    
    
}