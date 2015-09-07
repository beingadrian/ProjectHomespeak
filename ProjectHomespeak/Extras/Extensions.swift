//
//  Extensions.swift
//  ProjectHomespeak
//
//  Created by Adrian Wisaksana on 9/7/15.
//  Copyright (c) 2015 BeingAdrian. All rights reserved.
//

import Foundation


// MARK: - NSDate

extension NSDate {
    
    func beginningOfDay() -> NSDate {
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay, fromDate: self)
        
        return calendar.dateFromComponents(components)!
        
    }
    
}