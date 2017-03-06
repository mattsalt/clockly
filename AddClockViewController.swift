//
//  AddClockViewController.swift
//  Clockly
//
//  Created by Matthew on 06/03/2017.
//  Copyright © 2017 Matthew. All rights reserved.
//

import Cocoa

class AddClockViewController: NSViewController {

    @IBOutlet weak var timeZoneSelector: NSPopUpButton!
    @IBOutlet weak var addButton: NSButton!
    @IBOutlet weak var displayNameField: NSTextField!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        timeZoneSelector.removeAllItems()
        for (key,value) in TimeZone.abbreviationDictionary {
            timeZoneSelector.addItem(withTitle: "\(key) - \(value)")
        }
    }
    
    @IBAction func addClicked(_ sender: Any) {
        if let zone = timeZoneSelector.titleOfSelectedItem?.components(separatedBy: " - ")[0]{
            ClockManager.addClock(abbreviation: zone, displayName: displayNameField.stringValue)
        }
    }
}
