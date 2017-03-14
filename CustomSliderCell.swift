//
//  CustomSliderCell.swift
//  Clockly
//
//  Created by Matthew on 14/03/2017.
//  Copyright © 2017 Matthew. All rights reserved.
//

import Cocoa

class CustomSliderCell: NSSliderCell {
    
    override func drawBar(inside rect: NSRect, flipped: Bool) {

        let barRadius = CGFloat(2.5)
        let value = CGFloat((self.doubleValue - self.minValue) / (self.maxValue - self.minValue))
        let finalWidth = CGFloat(value * (self.controlView!.frame.size.width - 8))
        var leftRect = rect
        leftRect.size.width = finalWidth
        let bg = NSBezierPath(roundedRect: rect, xRadius: barRadius, yRadius: barRadius)
        NSColor.black.setFill()
        bg.fill()
        let active = NSBezierPath(roundedRect: leftRect, xRadius: barRadius, yRadius: barRadius)
        NSColor.blue.setFill()
        active.fill()
    }
    
    override func drawKnob(_ knobRect: NSRect) {
        super.drawKnob(knobRect)
    }

}
