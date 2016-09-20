//
//  ViewController.swift
//  Tippy
//
//  Created by Andy Jiang on 9/19/16.
//  Copyright © 2016 andyjiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var partyOfTwoLabel: UILabel!
    @IBOutlet weak var partyOfThreeLabel: UILabel!
    @IBOutlet weak var partyOfFourLabel: UILabel!
    @IBOutlet weak var partyOfFiveLabel: UILabel!
    @IBOutlet weak var partyOfSixLabel: UILabel!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    func getDefaultSegment() -> Int {
        return defaults.integerForKey("defaultSegment")
    }
    
    func updateDefaultSegment() {
        let defaultSegment = getDefaultSegment()
        tipControl.selectedSegmentIndex = defaultSegment
    }
    
    func getTipPercentage() -> Double {
        let tipPercentages = [0.18, 0.2, 0.25]
        return Double(tipPercentages[tipControl.selectedSegmentIndex])
    }
    
    func formatText(value: Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        return formatter.stringFromNumber(value)!
    }
    
    func getBillAmount() -> Double {
        return defaults.doubleForKey("billAmount")
    }
    
    func setBillAmount(amount: Double) {
        defaults.setDouble(amount, forKey: "billAmount")
    }
    
    func appWillTerminate() {
        let date = NSDate().timeIntervalSince1970
        defaults.setDouble(date, forKey: "dateTerminated")
        defaults.synchronize()
    }
    
    func wasAppRecentlyActive() -> Bool {
        let lastActive = defaults.doubleForKey("dateterminated")
        let now = NSDate().timeIntervalSince1970
        let duration = now - lastActive
        if (duration > 600) { return false }
        return true
    }
    
    func updateFields(bill: Double, tipPercentage: Double) {
        let tip = bill * tipPercentage
        let total = bill + tip
        
        tipLabel.text = formatText(tip)
        totalLabel.text = formatText(total)
        partyOfTwoLabel.text = formatText(total / 2)
        partyOfThreeLabel.text = formatText(total / 3)
        partyOfFourLabel.text = formatText(total / 4)
        partyOfFiveLabel.text = formatText(total / 5)
        partyOfSixLabel.text = formatText(total / 6)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billField.becomeFirstResponder()
        if (wasAppRecentlyActive()) {
            let billAmount = getBillAmount()
            billField.text = String(billAmount)
            updateFields(billAmount, tipPercentage: getTipPercentage())
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateDefaultSegment()
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        let tipPercentages = [0.18, 0.2, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        updateFields(bill, tipPercentage: tipPercentage)
    }
}

