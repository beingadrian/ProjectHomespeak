//
//  CircleAnimationA.swift
//  ProjectHomespeak
//
//  Created by Adrian Wisaksana on 9/12/15.
//  Copyright (c) 2015 BeingAdrian. All rights reserved.
//

import UIKit

class CircleAnimationA: CAShapeLayer {
   
    init(duration: CFTimeInterval, lineWidth: CGFloat) {
        super.init()
        
        let length: CGFloat = 150
        let bounds = CGRect(x: 0, y: 0, width: length, height: length)
        
        self.bounds = bounds
        self.cornerRadius = bounds.width / 2
        self.opacity = 0
        self.path = UIBezierPath(ovalInRect: bounds).CGPath
        self.lineWidth = lineWidth
        self.strokeColor = UIColor.lightGrayColor().CGColor
        self.fillColor = UIColor.clearColor().CGColor
        
        self.strokeStart = 0
        self.strokeEnd = 1
        
        // animate
        let pathAnimation = CABasicAnimation(keyPath: "path")
        let bounds2 = CGRect(x: -35, y: -35, width: 225, height: 225)
        let path2 = UIBezierPath(ovalInRect: bounds2).CGPath
        pathAnimation.toValue = path2
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.toValue = 1
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [pathAnimation, opacityAnimation]
        animationGroup.duration = duration
        animationGroup.autoreverses = true
        animationGroup.repeatCount = HUGE
        animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.addAnimation(animationGroup, forKey: nil)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
