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
        tableview.backgroundColor = NSColor.white
        meenu = NSMenu()
        meenu?.addItem(NSMenuItem(title: "Preferences",action: #selector(editClocks), keyEquivalent: ","))
        meenu?.addItem(NSMenuItem(title: "Quit Clockly",action: #selector(quit), keyEquivalent: "q"))
        editButton.menu = meenu
        tick()
    }
    
    override func viewDidAppear() {
        startTimer()
    }
    
    override func viewWillDisappear() {
        stopTimer()
    }

    
    func tick(){
        print("tick")
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
        tableview.reloadData()
    }
    
    @IBAction func sliderChanged(_ sender: Any) {
        tick()
    }
    
    
    // TURN THE TIMER ON AND OFF
    func startTimer(){
        tick()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
        timer?.invalidate()
        timer = nil
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
        let defaults = UserDefaults.standard
        let cell = tableView.make(withIdentifier: "popCell", owner: self) as? PopoverCell
        let clock = clocks[row]
        cell?.timezone = TimeZone.init(abbreviation:clock.abbreviation!)
        cell?.displayName = clock.displayName!
        cell?.showSeconds = defaults.integer(forKey: "showSeconds") == 1 ? true : false
        cell?.showDay = defaults.integer(forKey: "showDay") == 1 ? true : false
        return cell
    }
    

}
