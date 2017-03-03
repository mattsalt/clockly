//
//  ClockCell.swift
//  TableTest
//
//  Created by Matthew on 02/03/2017.
//  Copyright © 2017 Matthew. All rights reserved.
//

import Cocoa

class ClockCell: NSTableCellView {

    @IBOutlet weak var timeField: NSTextField!
    @IBOutlet weak var timezoneLabel: NSTextField!
    @IBOutlet weak var detailLabel: NSTextField!
    
    weak var viewController:ViewController!
    
    var timeZone:TimeZone?
    var displayName:String?
    var clockItem:ClockItem?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let date = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.timeStyle = DateFormatter.Style.medium
        timeField.stringValue = dateFormatter.string(from: date)
        timezoneLabel.stringValue = (timeZone?.abbreviation())!
        detailLabel.stringValue = displayName!
    }
    
    
    @IBAction func delete(_ sender: Any) {
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.managedObjectContext{
            do {
                context.delete(clockItem!)
                (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
                viewController.refresh()
            }catch{}
        }
    }
}
