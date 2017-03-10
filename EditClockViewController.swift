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
    
    @IBOutlet weak var showTimeWithSecondsCheckBox: NSButton!
    @IBOutlet weak var showDaysOfTheWeekCheckBox: NSButton!
   
    var popoverView:PopoverViewController?
    var clocks:[Clock] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        showDaysOfTheWeekCheckBox.state = defaults.integer(forKey: "showDay")
        showTimeWithSecondsCheckBox.state = defaults.integer(forKey: "showSeconds")

        clocks = ClockManager.getClocks()
        timezoneSelector.removeAllItems()
        for (key,value) in TimeZone.abbreviationDictionary {
            timezoneSelector.addItem(withTitle: "\(key) - \(value)")
        }
    }
    
    override func viewDidAppear() {
        self.view.window?.title = "Preferences"
    }
    
    func refresh(){
        popoverView?.reloadClocks()
        clocks = ClockManager.getClocks()
        tableView.reloadData()
        
    }
    
    @IBAction func addClicked(_ sender: Any) {
        print(clocks.count)
        if let zone = timezoneSelector.titleOfSelectedItem?.components(separatedBy: " - ")[0]{
            ClockManager.addClock(abbreviation: zone, displayName: displayNameField.stringValue, position:clocks.count)
        }
        clocks = ClockManager.getClocks()
        for item in clocks{
            print("\(item.displayName) - \(item.position)")
        }
        displayNameField.stringValue = ""
        refresh()
    }

    @IBAction func removeClicked(_ sender: Any) {
        if tableView.selectedRow > -1{
            if(tableView.selectedRow <= clocks.count - 1){
                ClockManager.deleteClock(clock: clocks[tableView.selectedRow])
                refresh()
            }
        }
    }
    
    //MARK: Preferences
    
    @IBAction func showSecondsToggled(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(showTimeWithSecondsCheckBox.state, forKey: "showSeconds")
        refresh()
    }
    
    @IBAction func showDayToggled(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(showDaysOfTheWeekCheckBox.state, forKey: "showDay")
        refresh()
    }
    
    //MARK: Sorting
    @IBAction func upClicked(_ sender: Any) {
        if(tableView.selectedRow < 0 ){
            return
        }
        //If top row selected do nothing
        if(tableView.selectedRow == 0){
            return
        }
        
        let selected = clocks.remove(at: tableView.selectedRow)
        selected.position = Int32(tableView.selectedRow - 1)
        clocks.insert(selected, at: Int(selected.position))
        
        for (index,clock) in clocks.enumerated(){
            clock.position = Int32(index)
        }
        
        (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
        refresh()
        tableView.selectRowIndexes([Int(selected.position)], byExtendingSelection: false)
    }
    
    @IBAction func downClicked(_ sender: Any) {
        if(tableView.selectedRow < 0 ){
            return
        }
        //If bottom row selected do nothing
        if(tableView.selectedRow == clocks.count - 1){
            return
        }
        
        let selected = clocks.remove(at: tableView.selectedRow)
        selected.position = Int32(tableView.selectedRow + 1)
        clocks.insert(selected, at: Int(selected.position))
        
        for (index,clock) in clocks.enumerated(){
            clock.position = Int32(index)
        }
        refresh()
        (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)

        tableView.selectRowIndexes([Int(selected.position)], byExtendingSelection: false)

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
