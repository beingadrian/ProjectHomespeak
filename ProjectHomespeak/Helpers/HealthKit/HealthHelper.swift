//
//  HKHelper.swift
//  ProjectHomespeak
//
//  Created by Adrian Wisaksana on 9/5/15.
//  Copyright (c) 2015 BeingAdrian. All rights reserved.
//

import Foundation
import HealthKit


class HealthHelper {
    
    // healthStore
    static let healthStore: HKHealthStore? = {
        if HKHealthStore.isHealthDataAvailable() {
            return HKHealthStore()
        } else {
            // TODO: Alert user if HealthKit not available
            return nil
        }
    }()
    
    // authorized
    static var healthKitIsAuthorized = false
    
    // stored data
    static var lastTotalSteps: Int = 0
    static var lastTotalDistance: Double = 0
    static var lastTotalActiveCalories: Double = 0
    
    
    // MARK: - Types to read
    
    static let stepsType = HKQuantityType.quantityTypeForIdentifier(
        HKQuantityTypeIdentifierStepCount
    )
    
    static let walkingRunningDistanceType = HKQuantityType.quantityTypeForIdentifier(
        HKQuantityTypeIdentifierDistanceWalkingRunning
    )
    
    static let activeEnergyType = HKQuantityType.quantityTypeForIdentifier(
        HKQuantityTypeIdentifierActiveEnergyBurned
    )
    
    
    // MARK: - Request permission method
    
    static func requestHealthKitAuthorization(completionBlock: (success: Bool, error: NSError?) -> Void) {
        
        let dataTypesToRead = NSSet(objects: stepsType, walkingRunningDistanceType, activeEnergyType)
        
        healthStore?.requestAuthorizationToShareTypes(nil, readTypes: dataTypesToRead as Set<NSObject>) {
            (success, error) in
            
            if (success) {
                self.healthKitIsAuthorized = true
            } else {
                self.healthKitIsAuthorized = false
            }
            
            completionBlock(success: success, error: error)
        }
        
    }
    
    
    // MARK: - Health quries
    
    // get all data set
    static func getHealthDataSet(completionBlock: (errors: [String: NSError?]) -> Void) {
        
        if (HealthHelper.healthKitIsAuthorized) {
            
            // errors
            var errors: [String: NSError?] = [:]
            
            // get healthKit data
            let begginingOfDay = NSDate().beginningOfDay()
            
            HealthHelper.getTotalStepsSinceDate(begginingOfDay) {
                (totalSteps, error) in
                
                if let error = error {
                    println(error.description)
                    errors["steps"] = error
                }
                
                if let totalSteps = totalSteps {
                    self.lastTotalSteps = totalSteps
                }
                
            }
            
            HealthHelper.getTotalDistanceSinceDate(begginingOfDay) {
                (totalDistance, error) in
                
                if let error = error {
                    println(error.description)
                    errors["distance"] = error
                }
                
                if let totalDistance = totalDistance {
                    // convert from meters to kilometers
                    let distanceInMeters = Double(totalDistance) / 1000
                    let roundedDistance = round(distanceInMeters * 10) / 10
                    self.lastTotalDistance = roundedDistance
                }
                
            }
            
            HealthHelper.getTotalActiveCaloriesBurnedSinceDate(begginingOfDay) {
                (totalActiveCaloriesBurned, error) in
                
                if let error = error {
                    println(error.description)
                    errors["calories"] = error
                }
                
                if let totalActiveCaloriesBurned = totalActiveCaloriesBurned {
                    // convert calories to kilocalories
                    let kilocalories = Double(totalActiveCaloriesBurned) / 1000
                    let roundedKiloCalories = round(kilocalories * 10) / 10
                    self.lastTotalActiveCalories = roundedKiloCalories
                }
                
            }
            
            completionBlock(errors: errors)
            
        }
        
    }
    
    
    // get total step count
    static func getTotalStepsSinceDate(date: NSDate, completionBlock: (totalStepCount: Int?, error: NSError?) -> Void) {

        // predicate from start of day
        let predicate = HKQuery.predicateForSamplesWithStartDate(date, endDate: NSDate(), options: .None)
        
        let sumOption = HKStatisticsOptions.CumulativeSum
        
        let totalStepCountQuery = HKStatisticsQuery(quantityType: stepsType, quantitySamplePredicate: predicate, options: sumOption) {
            (query, result, error) in
            
            if (error != nil) {
                // something happened
                println(error.description)
            }
            
            if let sumQuantity = result.sumQuantity() {
                let totalStepCount = Int(sumQuantity.doubleValueForUnit(HKUnit.countUnit()))
                completionBlock(totalStepCount: totalStepCount, error: error)
            } else {
                // there is no sum quantity due to no sample (too short of a time period)
                println("There is no sum quantity")
                completionBlock(totalStepCount: nil, error: error)
            }
            
        }
        
        healthStore?.executeQuery(totalStepCountQuery)
        
    }
    
    // get total walking and running distance
    static func getTotalDistanceSinceDate(date: NSDate, completionBlock: (totalDistance: Int?, error: NSError?) -> Void) {

        // predicate from start of day
        let predicate = HKQuery.predicateForSamplesWithStartDate(date, endDate: NSDate(), options: .None)
        
        let sumOption = HKStatisticsOptions.CumulativeSum
        
        let totalDistanceQuery = HKStatisticsQuery(quantityType: walkingRunningDistanceType, quantitySamplePredicate: predicate, options: sumOption) {
            (query, result, error) in
            
            if (error != nil) {
                // something happened
                println(error.description)
            }
            
            if let sumQuantity = result?.sumQuantity() {
                let totalDistance = Int(sumQuantity.doubleValueForUnit(HKUnit.meterUnit()))
                completionBlock(totalDistance: totalDistance, error: error)
            } else {
                // there is no sum quantity due to no sample (too short of a time period)
                println("There is no sum quantity")
                completionBlock(totalDistance: nil, error: error)
            }
            
        }
        
        healthStore?.executeQuery(totalDistanceQuery)
        
    }
    
    // get total active energy burned
    static func getTotalActiveCaloriesBurnedSinceDate(date: NSDate, completionBlock: (totalActiveCalories: Int?, error: NSError?) -> Void) {
        
        // predicate from start of day
        let predicate = HKQuery.predicateForSamplesWithStartDate(date, endDate: NSDate(), options: .None)
        
        let sumOption = HKStatisticsOptions.CumulativeSum
        
        let totalActiveCaloriesBurnedQuery = HKStatisticsQuery(quantityType: activeEnergyType, quantitySamplePredicate: predicate, options: sumOption) {
            (query, result, error) in
            
            if (error != nil) {
                // something happened
                println(error.description)
            }
            
            if let sumQuantity = result?.sumQuantity() {
                let totalActiveCaloriesBurned = Int(sumQuantity.doubleValueForUnit(HKUnit.calorieUnit()))
                completionBlock(totalActiveCalories: totalActiveCaloriesBurned, error: error)
            } else {
                // there is no sum quantity due to no sample (too short of a time period)
                println("There is no sum quantity")
                completionBlock(totalActiveCalories: nil, error: error)
            }
            
        }
        
        healthStore?.executeQuery(totalActiveCaloriesBurnedQuery)
        
    }
}