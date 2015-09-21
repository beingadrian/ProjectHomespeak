//
//  ReportViewController.swift
//  ProjectHomespeak
//
//  Created by Adrian Wisaksana on 9/8/15.
//  Copyright (c) 2015 BeingAdrian. All rights reserved.
//

import UIKit
import AVFoundation



class ReportViewController: UIViewController {
    
    // MARK: - Properties
    var backgroundShape: CAShapeLayer!
    var startShapeBezier: UIBezierPath!
    
    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set status bar style
        navigationController?.navigationBar.barStyle = .Default
    
    }
    
    override func viewDidAppear(animated: Bool) {
        
        SpeechHelper.speakFullReport()
        
        // animated circle
        let animatedCircleA = CircleAnimationA(duration: 1, lineWidth: 4)
        animatedCircleA.position = CGPoint(x: view.center.x, y: view.center.y)
        view.layer.addSublayer(animatedCircleA)
        
        let animatedCircleB = CircleAnimationA(duration: 2, lineWidth: 3)
        animatedCircleB.position = CGPoint(x: view.center.x, y: view.center.y)
        view.layer.addSublayer(animatedCircleB)
        
        let animatedCircleC = CircleAnimationA(duration: 4, lineWidth: 2)
        animatedCircleC.position = CGPoint(x: view.center.x, y: view.center.y)
        view.layer.addSublayer(animatedCircleC)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func returnButtonPressed(sender: AnyObject) {
        
        // stop speech
        SpeechHelper.synthesizer.stopSpeakingAtBoundary(.Immediate)
        
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    

}




