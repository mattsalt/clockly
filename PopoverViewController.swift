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

    @IBOutlet weak var editButton: NSButton!
    @IBOutlet weak var slider: NSSlider!
    var clocks:[Clock] = []
    var timer:Timer?
    var popover:NSPopover?
    var meenu:NSMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clocks = ClockManager.getClocks()
        clocks.sort { (c1, c2) -> Bool in
            c1.position < c2.position
        }
        tableview.backgroundColor = NSColor.white
        meenu = NSMenu()
        meenu?.addItem(NSMenuItem(title: "Edit Clocks",action: #selector(editClocks), keyEquivalent: ","))
        meenu?.addItem(NSMenuItem(title: "Quit Clockly",action: #selector(quit), keyEquivalent: "q"))
        editButton.menu = meenu
        tick()
    }
    
    func tick(){
        for (index, _) in clocks.enumerated() {
            if let cell = tableview.view(atColumn: 0, row: index, makeIfNecessary: false) as? PopoverCell{
                cell.tick(adjustment: slider.doubleValue)
            }
        }
    }
    
    @IBAction func editButtonClicked(_ sender: Any) {
        meenu?.popUp(positioning: meenu?.item(at: 0), at: NSEvent.mouseLocation(), in: nil)
    }
    
    func reloadClocks(){
        clocks = ClockManager.getClocks()
        clocks.sort { (c1, c2) -> Bool in
            c1.position < c2.position
        }
        tableview.reloadData()
    }
    
    @IBAction func sliderChanged(_ sender: Any) {
        tick()
    }
    
    // TURN THE TIMER ON AND OFF
    func startTimer(){
        tick()
        timer = Timer.scheduledTimer(timeInterval: 0.33, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
        
    }
    
    func stopTimer(){
        timer?.invalidate()
    }
    
    //MARK: NAVIGATION
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditWindow" {
            popover?.performClose(self)
            let controller = segue.destinationController as! EditClockViewController
            controller.popoverView = self
        }
    }
    
    //MARK: Menu methods
    func editClocks(){
        performSegue(withIdentifier: "showEditWindow", sender: self)
    }
    
    func quit(){
        NSApplication.shared().terminate(self)
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
