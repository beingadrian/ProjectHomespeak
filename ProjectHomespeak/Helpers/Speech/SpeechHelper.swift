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
    
    static func speakText(string: String) {
        
        let textToSpeak = string
        
        let utterance = AVSpeechUtterance(string: textToSpeak)
        utterance.rate = AVSpeechUtteranceMinimumSpeechRate
        
        synthesizer.speakUtterance(utterance)
        
    }
    
    static func speakHealthKitData() {
        
        let string = "Today you walked \(HealthHelper.lastTotalSteps) steps. That's a total of \(HealthHelper.lastTotalDistance) kilometers. You also burned \(HealthHelper.lastTotalActiveCalories) kilocalories. Awesome job mate."
        
        let utterance = AVSpeechUtterance(string: string)
        utterance.rate = AVSpeechUtteranceMinimumSpeechRate
        
        synthesizer.speakUtterance(utterance)
        
    }
    
}