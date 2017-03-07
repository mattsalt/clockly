//
//  PopoverViewController.swift
//  Clockly
//
//  Created by Matthew on 06/03/2017.
//  Copyright © 2017 Matthew. All rights reserved.
//

import Cocoa

class PopoverViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var addButton: NSButton!
    @IBOutlet weak var tableview: NSTableView!

    @IBOutlet weak var addButtonCell: NSButtonCell!
    var clocks:[Clock] = []
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clocks = ClockManager.getClocks()
        tableview.backgroundColor = NSColor.white
        tick()
    }
    
    func tick(){
        for (index, _) in clocks.enumerated() {
            if let cell = tableview.view(atColumn: 0, row: index, makeIfNecessary: false) as? PopoverCell{
                cell.tick()
            }
        }
    }
    
    func reloadClocks(){
        clocks = ClockManager.getClocks()
        tableview.reloadData()
    }
    
    // TURN THE TIMER ON AND OFF
    func startTimer(){
        tick()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
        timer?.invalidate()
    }
    
    //MARK: NAVIGATION
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditWindow" {
            let controller = segue.destinationController as! EditClockViewController
            controller.popoverView = self
        }
    }
    
    //MARK: TABLE METHODS
    func numberOfRows(in tableView: NSTableView) -> Int {
        return clocks.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier: "popCell", owner: self) as? PopoverCell
        let clock = clocks[row]
        cell?.timezone = TimeZone.init(abbreviation:clock.abbreviation!)
        cell?.displayName = clock.displayName!
        return cell
    }
}
