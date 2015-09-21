//
//  MainViewController.swift
//  ProjectHomespeak
//
//  Created by Adrian Wisaksana on 9/5/15.
//  Copyright (c) 2015 BeingAdrian. All rights reserved.
//

import UIKit
import AVFoundation


class MainViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var dataActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var reportButton: UIButton!
    
    
    // MARK: - 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // permission for notifications
        let notificationSettings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        // set status bar style
        navigationController?.navigationBar.barStyle = .Black
        
        if (Manager.userIsSetup) {
            
            // get report data
            Manager.getFullReportData() {
                (errors) in
                
                // TODO: error handling
                for (index, hasError) in errors {
                    if (hasError) {
                        println("\(index) has error.")
                    }
                }
                
                // animate alpha switch when data loaded
                UIView.animateWithDuration(1) {
                    
                    self.dataActivityIndicator.stopAnimating()
                    self.reportButton.alpha = 1
                    
                }
                
            }
            
        } else {
            
            dataActivityIndicator.stopAnimating()
            reportButton.setTitle("Setup Homespeak", forState: .Normal)
            reportButton.alpha = 1

            
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        
        HealthHelper.requestHealthKitAuthorization() {
            (success, error) in
            
            if (error != nil) {
                println(error?.description)
            }
            
            if (success) {
                println("HealthKit authorization successful.")
            } else {
                println("HealthKit authorization not successful.")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showReportView(sender: UIButton) {
        
        if Manager.userIsSetup {
            
            // report VC
            performSegueWithIdentifier("ReportView", sender: self)
            
        } else {
            
            // setup VC
            performSegueWithIdentifier("SetupView", sender: self)
            
        }
        
        
        
    }
    
}

extension MainViewController: UITableViewDataSource {
    
    // set number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Manager.integrations.count
        
    }
    
    // do things with rows
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("IntegrationCell") as! IntegrationCell
        
        // set image file names for states
        let buttonImageNameNormal = Manager.integrationImagesNormal[indexPath.row]
        cell.integrationToggleButton.setImage(UIImage(named: buttonImageNameNormal), forState: .Normal)
        
        let buttonImageNameSelected = Manager.integrationImagesSelected[indexPath.row]
        cell.integrationToggleButton.setImage(UIImage(named: buttonImageNameSelected), forState: .Selected)
        
        // button toggle
        if Manager.activeIntegrationsArray[indexPath.row] {
            cell.integrationToggleButton.selected = true
        }
        
        // set labels
        cell.integrationLabel.text = Manager.integrations[indexPath.row]
        
        // set selection style
        cell.selectionStyle = .None
        
        // set index
        cell.index = indexPath.row
        
        return cell
        
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return Manager.integrationRowHeight
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // deselect row (because we need to)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        switch (indexPath.row) {
        case 0:
            performSegueWithIdentifier("FitnessReport", sender: self)
        case 1:
            performSegueWithIdentifier("AutoMusic", sender: self)
        default:
            break
        }
    
    }
    
}
