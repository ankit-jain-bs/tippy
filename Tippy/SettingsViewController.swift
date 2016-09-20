//
//  SettingsViewController.swift
//  Tippy
//
//  Created by Andy Jiang on 9/19/16.
//  Copyright © 2016 andyjiang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var surpriseMeButton: UIButton!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    func setDefaultSegment(index: Int) {
        defaults.setInteger(index, forKey: "defaultSegment")
    }
    
    func getDefaultSegment() -> Int {
        return defaults.integerForKey("defaultSegment")
    }
    
    func updateDefaultSegment() {
        tipControl.selectedSegmentIndex = getDefaultSegment()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        surpriseMeButton.layer.cornerRadius = 4
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateDefaultSegment()
    }
    
    @IBAction func onButtonClick(sender: AnyObject) {
        setDefaultSegment(sender.selectedSegmentIndex)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
