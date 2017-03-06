//
//  PopoverViewController.swift
//  Clockly
//
//  Created by Matthew on 06/03/2017.
//  Copyright © 2017 Matthew. All rights reserved.
//

import Cocoa

class PopoverViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var tableview: NSTableView!

    var clocks:[Clock] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clocks = ClockManager.getClocks()
        tableview.backgroundColor = NSColor.white
        tick()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    func tick(){
        tableview.reloadData()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return clocks.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier: "popCell", owner: self) as? PopoverCell
        var clock = clocks[row]
        cell?.timezone = clock.timeZone
        cell?.displayName = clock.displayName
        return cell
    }
    

    
}
