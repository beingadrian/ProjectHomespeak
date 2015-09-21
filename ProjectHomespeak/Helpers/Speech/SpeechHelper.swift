//
//  SpeechHelper.swift
//  ProjectHomespeak
//
//  Created by Adrian Wisaksana on 9/8/15.
//  Copyright (c) 2015 BeingAdrian. All rights reserved.
//

import Foundation
import AVFoundation

class SpeechHelper {
    
    // declare synthesizer
    static let synthesizer = AVSpeechSynthesizer()

    
    // MARK: - Speech functions
    
    static func speakFullReport() {
        
        SpeechHelper.speakText("Greetings mate.")
        
        // count for active integration
        var activeIntegrationsCount = 0
        
        for index in 0...3 {
            if Manager.activeIntegrationsArray[index] {
                activeIntegrationsCount++
            }
        }
        
        if (activeIntegrationsCount == 0) {
            SpeechHelper.speakText("No integrations activated.")
        }
        
        // if some integrations active
        if (Manager.activeIntegrationsArray[0]) {
            SpeechHelper.speakHealthKitData()
        }
        
    }
    
    static func speakText(string: String) {
        
        let textToSpeak = string
        
        let utterance = AVSpeechUtterance(string: textToSpeak)
        utterance.rate = AVSpeechUtteranceMinimumSpeechRate
        utterance.voice = AVSpeechSynthesisVoice(language: "en-gb")
        
        synthesizer.speakUtterance(utterance)
        
    }
    
    static func speakHealthKitData() {
        
        if (HealthHelper.healthKitIsAuthorized) {
            let string = "Today you have walked \(HealthHelper.lastTotalSteps) steps. That's a total of \(HealthHelper.lastTotalDistance) kilometers. You have also burned \(HealthHelper.lastTotalActiveCalories) kilo-calories. Awesome job mate."
            
            let utterance = AVSpeechUtterance(string: string)
            utterance.rate = AVSpeechUtteranceMinimumSpeechRate
            utterance.voice = AVSpeechSynthesisVoice(language: "en-gb")
            
            synthesizer.speakUtterance(utterance)
        } else {
            speakText("HealthKit is not authorized.")
        }
        

        
    }
    
}