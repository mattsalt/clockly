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
    @IBOutlet weak var dayLabel: NSTextField!
    
    let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
   
    var timezone:TimeZone?
    var displayName = ""
    var dateFormatter = DateFormatter()
    var dateFormatter2 = DateFormatter()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = timezone
        
        timeLabel.textColor = NSColor.black
        abbreviationLabel.textColor = NSColor.black
        descriptionLabel.textColor = NSColor.black
        dayLabel.textColor = NSColor.lightGray
        
        let date = Date()
        timeLabel.stringValue = dateFormatter.string(from: date)
        abbreviationLabel.stringValue = dateFormatter.timeZone.abbreviation()!
        descriptionLabel.stringValue = displayName
    }
    
    func tick(adjustment: Double){
        var date = Date()
        let timeInterval:TimeInterval = adjustment * 60.0 * 60.0
        date = date.addingTimeInterval(timeInterval)
        timeLabel.stringValue = dateFormatter.string(from: date)
        var calendar = Calendar.current
        calendar.timeZone = timezone!
        let day = calendar.component(.weekday, from: date)
        dayLabel.stringValue = days[day]
    }
}
