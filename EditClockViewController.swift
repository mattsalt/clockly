//
//  EditClockViewController.swift
//  Clockly
//
//  Created by Matthew on 07/03/2017.
//  Copyright © 2017 Matthew. All rights reserved.
//

import Cocoa

class EditClockViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var timezoneSelector: NSPopUpButton!
    @IBOutlet weak var displayNameField: NSTextField!
    @IBOutlet weak var addButton: NSButton!
    @IBOutlet weak var removeButton: NSButton!
    
    var popoverView:PopoverViewController?
    var clocks:[Clock] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        clocks = ClockManager.getClocks()
        timezoneSelector.removeAllItems()
        for (key,value) in TimeZone.abbreviationDictionary {
            timezoneSelector.addItem(withTitle: "\(key) - \(value)")
        }
    }
    
    override func viewDidAppear() {
        self.view.window?.title = "Edit Clocks"
    }
    
    func refresh(){
        tableView.reloadData()
        popoverView?.reloadClocks()
    }
    @IBAction func addClicked(_ sender: Any) {
        if let zone = timezoneSelector.titleOfSelectedItem?.components(separatedBy: " - ")[0]{
            ClockManager.addClock(abbreviation: zone, displayName: displayNameField.stringValue)
        }
        clocks = ClockManager.getClocks()
        refresh()
    }

    @IBAction func removeClicked(_ sender: Any) {
        
    }
    

    
    
    //MARK: Table Methods
    func numberOfRows(in tableView: NSTableView) -> Int {
        return ClockManager.getClocks().count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        
        if tableColumn?.identifier == "timezone" {
            if let cell = tableView.make(withIdentifier: "timezone", owner: self) as? NSTableCellView{
                cell.textField?.stringValue = clocks[row].abbreviation!
                return cell
            }
        }else{
            if let cell = tableView.make(withIdentifier: "timezone", owner: self) as? NSTableCellView{
                cell.textField?.stringValue = clocks[row].displayName!
                return cell
            }
        }
        return nil
    }
    
}
