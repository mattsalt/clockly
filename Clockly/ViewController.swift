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
    var timezones:[String] = []
    
    @IBOutlet weak var timeZoneSelector: NSPopUpButton!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var displayNameField: NSTextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        timeZoneSelector.removeAllItems()
        for (key,value) in TimeZone.abbreviationDictionary {
            timeZoneSelector.addItem(withTitle: "\(key) - \(value)")
        }
        clocks = getClocks()
    }
    
    func getClocks() -> [Clock]{
        var clocks:[Clock] = []
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.managedObjectContext{
            do {
                let dataFetchRequest: NSFetchRequest<NSFetchRequestResult> = Clock.fetchRequest()
                clocks = try context.fetch(dataFetchRequest) as! [Clock]
                if(clocks.count == 0){
                    let clock = Clock(context: context)
                    clock.displayName = "London"
                    clock.abbreviation = "GMT"
                    clocks.append(clock)
                }
            }catch{}
        }
        return clocks
    }
    
    func tick(){
        clocks = getClocks()
        tableView.reloadData()
    }
    
    func refresh(){
        clocks = getClocks()
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
        cell?.timeZone = TimeZone.init(abbreviation:clock.abbreviation!)
        cell?.displayName = clock.displayName
        cell?.viewController = self
        cell?.clock = clock
        return cell
    }
    
    @IBAction func addClicked(_ sender: Any) {
        if let zone = timeZoneSelector.titleOfSelectedItem?.components(separatedBy: " - ")[0]{
            if let context = (NSApplication.shared().delegate as? AppDelegate)?.managedObjectContext {
                let clock = Clock(context: context)
                clock.displayName = displayNameField.stringValue
                clock.abbreviation = zone
                clocks.append(clock)
                (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
            }
            tableView.reloadData()
        }

    }
}

