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
    
    static func speakHealthKitDataWithVariables(steps: Int, distance: Int, calories: Int) {
        
        let string = "Greetings, Adrian. Today you walked \(steps) steps. That's a total of \(distance) kilometers. You also burned \(calories). Awesome job."
        
        let utterance = AVSpeechUtterance(string: string)
        utterance.rate = AVSpeechUtteranceMinimumSpeechRate
        
        synthesizer.speakUtterance(utterance)
        
    }
    
    static func speakFullReport() {
    
    
    
    }
    
    static func speakHealthKitDataSample() {
        
        let string = "Greetings, Adrian. Today you walked 1000 steps. That's a total of 2 kilometers. You also burned 10 kilocalories. Awesome job."
        
        let utterance = AVSpeechUtterance(string: string)
        utterance.rate = AVSpeechUtteranceMinimumSpeechRate
        
        synthesizer.speakUtterance(utterance)
        
    }
    
}