//
//  PopoverCell.swift
//  Clockly
//
//  Created by Matthew on 06/03/2017.
//  Copyright © 2017 Matthew. All rights reserved.
//

import Cocoa

class PopoverCell: NSTableCellView {

    @IBOutlet weak var timeLabel: NSTextField!
    @IBOutlet weak var abbreviationLabel: NSTextField!
    @IBOutlet weak var descriptionLabel: NSTextField!
   
    var timezone:TimeZone?
    var displayName = ""
    var dateFormatter = DateFormatter()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = timezone
        
        timeLabel.textColor = NSColor.black
        abbreviationLabel.textColor = NSColor.black
        descriptionLabel.textColor = NSColor.black
        
        let date = Date()
        timeLabel.stringValue = dateFormatter.string(from: date)
        abbreviationLabel.stringValue = dateFormatter.timeZone.abbreviation()!
        descriptionLabel.stringValue = displayName
    }
    
    func tick(){
        let date = Date()
        timeLabel.stringValue = dateFormatter.string(from: date)
    }
    
}
