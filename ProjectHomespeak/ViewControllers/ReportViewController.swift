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
    
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // get data
        Manager.getFullReportData() {
            (errors) in
            
            SpeechHelper.speakFullReport()
    
        }
        
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.Default
        
    }

    
    // MARK: - Actions
    
    @IBAction func returnButtonPressed(sender: AnyObject) {
        
        // TODO: stop speech if necessary
        SpeechHelper.synthesizer.stopSpeakingAtBoundary(.Immediate)
        
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    
    

}




