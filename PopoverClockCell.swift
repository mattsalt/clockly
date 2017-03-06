//
//  PopoverClockCell.swift
//  Clockly
//
//  Created by Matthew on 03/03/2017.
//  Copyright © 2017 Matthew. All rights reserved.
//

import Cocoa

class PopoverClockCell: NSTableCellView {


    
    var timeZone:TimeZone?
    var displayName:String?
    var timeDisplay:String?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.timeStyle = DateFormatter.Style.medium
       timeDisplay = dateFormatter.string(from: date)
//       timezoneLabel.stringValue = (timeZone?.abbreviation())!
//        detailLabel.stringValue = displayName!
    }
    
}
