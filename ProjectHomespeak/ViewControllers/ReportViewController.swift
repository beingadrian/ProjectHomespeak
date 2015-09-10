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
    
    // MARK: - Code connection
    
    
    
    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set status bar style
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // get data
        Manager.getFullReportData() {
            (errors) in
            
            SpeechHelper.speakFullReport()
        }
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnButtonPressed(sender: AnyObject) {
        
        // TODO: stop speech if necessary
        SpeechHelper.synthesizer.stopSpeakingAtBoundary(.Immediate)
    
    }

}
