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

    override func viewDidLoad() {
        super.viewDidLoad()
                
        

    }
    
    override func viewDidAppear(animated: Bool) {
        
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showReportView(sender: UIButton) {
        
        performSegueWithIdentifier("ReportView", sender: self)
        
    }
    
    // unwind to segue for report view controller
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
    
        
        
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
