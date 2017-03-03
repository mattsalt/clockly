//
//  ViewController.swift
//  TableTest
//
//  Created by Matthew on 02/03/2017.
//  Copyright © 2017 Matthew. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    var clocks:[Clock] = []
    var clockItems:[ClockItem] = []
    var timezones:[String] = []
    
    @IBOutlet weak var timeZoneSelector: NSPopUpButton!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var displayNameField: NSTextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.managedObjectContext {
            let clockItem = ClockItem(context: context)
            clockItem.displayName = "London"
            clockItem.abbreviation = "GMT"
            clockItems.append(clockItem)
        }
        
        
        timeZoneSelector.removeAllItems()
        for (key,value) in TimeZone.abbreviationDictionary {
            timeZoneSelector.addItem(withTitle: "\(key) - \(value)")
        }
        getClocks()

        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)

    }
    
    func getClocks(){
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.managedObjectContext{
            do {
                clocks = []
                let dataFetchRequest: NSFetchRequest<NSFetchRequestResult> = ClockItem.fetchRequest()
                clockItems = try context.fetch(dataFetchRequest) as! [ClockItem]
                for item in clockItems {
                    clocks.append(Clock(timeZone: TimeZone(abbreviation: item.abbreviation!)!, displayName: item.displayName!)!)
                }
            }catch{}
            
        }
    }
    
    func tick(){
        getClocks()
        tableView.reloadData()
    }
    
    func refresh(){
        getClocks()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return clocks.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier: "clockCell", owner: self) as? ClockCell
        let clock = clocks[row]
        cell?.clockItem = clockItems[row]
        cell?.timeZone = clock.timeZone
        cell?.displayName = clock.displayName
        cell?.viewController = self
        return cell
    }
    
    @IBAction func addClicked(_ sender: Any) {
        if let zone = timeZoneSelector.titleOfSelectedItem?.components(separatedBy: " - ")[0]{
            if let context = (NSApplication.shared().delegate as? AppDelegate)?.managedObjectContext {
                let clockItem = ClockItem(context: context)
                clockItem.displayName = displayNameField.stringValue
                clockItem.abbreviation = zone
                clockItems.append(clockItem)
                (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
            }
            clocks.append(Clock(timeZone: TimeZone(abbreviation: zone)!, displayName: displayNameField.stringValue)!)
            tableView.reloadData()
        }

    }
}

