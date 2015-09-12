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
    @IBOutlet weak var subview: UIView!
    var backgroundShape: CAShapeLayer!
    var startShapeBezier: UIBezierPath!
    
    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showCircularBackground()
    
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // get data
        Manager.getFullReportData() {
            (errors) in
            
            SpeechHelper.speakFullReport()
    
        }
        
        showCircularAnimation()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.Default
        
    }
    
    // custom background function
    func showCircularBackground() {
        
        // Create CAShapeLayer
        backgroundShape = CAShapeLayer()
        backgroundShape.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        backgroundShape.cornerRadius = backgroundShape.bounds.width / 2
        backgroundShape.position = CGPoint(x: view.center.x, y: view.bounds.height + 100)
        backgroundShape.fillColor = UIColor.whiteColor().CGColor
        backgroundShape.zPosition = -1
        
        // add backgroundShape
        view.layer.addSublayer(backgroundShape)
        
        // begin with a circle with a 50 points radius
        startShapeBezier = UIBezierPath(roundedRect: backgroundShape.bounds, cornerRadius: 50)
        let startShape = startShapeBezier.CGPath
        
        // animation end with a large circle
        let endShape = UIBezierPath(roundedRect: CGRect(x: -960, y: -950, width: 2000, height: 2000), cornerRadius: 1000).CGPath
        
        // set initial shape
        backgroundShape.path = startShape
    
        // animate the `path`
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = endShape
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fillMode = kCAFillModeBoth
        animation.removedOnCompletion = false
        
        // execute animation
        backgroundShape.addAnimation(animation, forKey: animation.keyPath)
        
    }
    
    func showCircularAnimation() {
        
        let length: CGFloat = 150
        let bounds = CGRect(x: 0, y: 0, width: length, height: length)
        
        // Create CAShapeLayerS
        let rectShape = CAShapeLayer()
        rectShape.bounds = bounds
        rectShape.position = CGPoint(x: view.center.x, y: view.center.y + 50)
        rectShape.cornerRadius = bounds.width / 2
        rectShape.opacity = 0
        subview.layer.addSublayer(rectShape)
        
        rectShape.path = UIBezierPath(ovalInRect: rectShape.bounds).CGPath
        
        rectShape.lineWidth = 4.0
        rectShape.strokeColor = UIColor.lightGrayColor().CGColor
        rectShape.fillColor = UIColor.clearColor().CGColor
        
        rectShape.strokeStart = 0
        rectShape.strokeEnd = 1
        
        let pathAnimation = CABasicAnimation(keyPath: "path")
        let bounds2 = CGRect(x: -15, y: -15, width: 180, height: 180)
        let path2 = UIBezierPath(ovalInRect: bounds2).CGPath
        pathAnimation.toValue = path2
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.toValue = 1
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [pathAnimation, opacityAnimation]
        animationGroup.duration = 1
        animationGroup.autoreverses = true
        animationGroup.repeatCount = HUGE
        animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        rectShape.addAnimation(animationGroup, forKey: nil)
        
    }
    
    // MARK: - Actions
    
    @IBAction func returnButtonPressed(sender: AnyObject) {
        
        // TODO: stop speech if necessary
        SpeechHelper.synthesizer.stopSpeakingAtBoundary(.Immediate)
        
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    
    

}




