//
//  PopoverCell.swift
//  Clockly
//
//  Created by Matthew on 06/03/2017.
//  Copyright © 2017 Matthew. All rights reserved.
//

import Cocoa

class PopoverCell: NSTableCellView {

    var timeLabel: NSTextField = NSTextField.init(frame: NSRect.init(x: 5, y: 25, width: 80, height: 21))

    @IBOutlet weak var descriptionLabel: NSTextField!
    @IBOutlet weak var dayLabel: NSTextField!
    @IBOutlet weak var clockView: ClockView!
    
    let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
   
    var timezone:TimeZone?
    var displayName = ""
    var dateFormatter = DateFormatter()
    var showDay = false
    var showSeconds = false
    var analog = false
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        dateFormatter.timeStyle = showSeconds ? DateFormatter.Style.medium : DateFormatter.Style.short
        dateFormatter.timeZone = timezone
        clockView.timezone = timezone
        descriptionLabel.textColor = NSColor.black
        dayLabel.textColor = NSColor.lightGray
        
        descriptionLabel.stringValue = displayName
        dayLabel.isHidden = showDay ? false : true
        
        timeLabel.isBordered = false
        timeLabel.backgroundColor = NSColor.white
        timeLabel.font = NSFont.systemFont(ofSize: 18.0)
        timeLabel.textColor = NSColor.black
        self.addSubview(timeLabel)
        
        if(!analog){
            clockView.isHidden = true
            timeLabel.isHidden = false
        }else{
            clockView.isHidden = false
            timeLabel.isHidden = true
        }
        
        tick(adjustment:0.0)

    }
    
    func tick(adjustment: Double){
        let timeInterval:TimeInterval = adjustment * 60.0 * 60.0
        let date = Date().addingTimeInterval(timeInterval)

        timeLabel.stringValue = dateFormatter.string(from: date)
        timeLabel.textColor = NSColor.black
        var calendar = Calendar.current
        calendar.timeZone = timezone!
        let day = calendar.component(.weekday, from: date)
        dayLabel.stringValue = days[day-1]
        
        if(!clockView.isHidden){
            clockView.showSecondHand = showSeconds
            clockView.update(adjustment: adjustment)
        }
    }
}
