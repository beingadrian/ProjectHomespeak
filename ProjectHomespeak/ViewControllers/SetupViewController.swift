//
//  SetupViewController.swift
//  ProjectHomespeak
//
//  Created by Adrian Wisaksana on 9/12/15.
//  Copyright (c) 2015 BeingAdrian. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class SetupViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    let locationManager = CLLocationManager()
    
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set nav bar color
        let greyColorValue: CGFloat = 74/255
        navBar.backgroundColor = UIColor(red: greyColorValue, green: greyColorValue, blue: greyColorValue, alpha: 1)
        
        // location manager
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
                
    }
    
    // TODO: manage map memory allocation issues
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
        
    }
    
    // MARK: - Actions
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true) {
            
            // insert code here
            
        }
        
    }
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        
        // add function code here
        
    }
    
}

extension SetupViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    
}
