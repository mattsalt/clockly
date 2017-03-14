//
//  ClockView.swift
//  ClockTest
//
//  Created by Matthew on 13/03/2017.
//  Copyright © 2017 Matthew. All rights reserved.
//

import Cocoa

class ClockView: NSView {
    
    var adjustment: Double = 0
    var timezone:TimeZone?
    var backgroundDrawn = false
    var showSecondHand = true
    
    var clockFrame: CGRect {
        return clockFrameForBounds(bounds: bounds)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        if(!backgroundDrawn){
            NSColor.white.setFill()
            NSBezierPath.fill(bounds)
            drawBackground()
            drawTicks()
//            drawNumbers(fontSize: 0.071770334, radius: 0.402711324)
        }
        
        var calendar = NSCalendar.current
        calendar.timeZone = timezone!
        
        let timeInterval:TimeInterval = adjustment * 60.0 * 60.0
        let comps = calendar.dateComponents([.second, .minute, .hour], from: Date().addingTimeInterval(timeInterval))
        
        let seconds = Double(comps.second!) / 60.0
        let minutes = (Double(comps.minute!) / 60.0) + (seconds / 60.0)
        let hours = (Double(comps.hour!) / 12.0) + ((minutes / 60.0) * (60.0 / 12.0))
        drawTime(components: comps, hours: hours, minutes: minutes, seconds: seconds)
    }
    
    func tick(){
        self.needsDisplay = true
    }
    
    func update(adjustment: Double){
        self.adjustment = adjustment
        tick()
    }
    
    func drawBackground(){
        let clockPath = NSBezierPath(ovalIn: clockFrame)
        clockPath.lineWidth = 4
        clockPath.fill()
    }
    
    func clockFrameForBounds(bounds: CGRect) -> CGRect {
        let size = bounds.size
        let clockSize = min(size.width, size.height)
        
        let rect = CGRect(x: (size.width - clockSize) / 2.0, y: (size.height - clockSize) / 2.0, width: clockSize, height: clockSize)
        return rect
    }
    
    func drawTicks() {
        drawTicksDivider(color: NSColor.black.withAlphaComponent(0.05), position: 0.074960128)
        
        let color = NSColor.black
        drawTicks(minorColor: color.withAlphaComponent(0.5), minorLength: 0.049441786, minorThickness: 0.004784689, majorColor: color, majorThickness: 0.009569378, inset: 0.014)
    }
    
    func drawTicksDivider(color: NSColor, position: Double) {
        color.setStroke()
        let ticksFrame = clockFrame.insetBy(dx: clockFrame.size.width * CGFloat(position), dy: clockFrame.size.width * CGFloat(position))
        let ticksPath = NSBezierPath(ovalIn: ticksFrame)
        ticksPath.lineWidth = 1
        ticksPath.stroke()
    }
    
    func drawTicks(minorColor: NSColor, minorLength: Double, minorThickness: Double, majorColor _majorColor: NSColor? = nil, majorLength _majorLength: Double? = nil, majorThickness _majorThickness: Double? = nil, inset: Double = 0.0) {
        let majorColor = _majorColor ?? minorColor
        let majorLength = _majorLength ?? minorLength
        let majorThickness = _majorThickness ?? minorThickness
        let center = CGPoint(x: clockFrame.midX, y: clockFrame.midY)
        
        // Ticks
        let clockWidth = clockFrame.size.width
        let tickRadius = (clockWidth / 2.0) - (clockWidth * CGFloat(inset))
        for i in 0..<60 {
            if( i % 5 == 0){
            let isMajor = (i % 5) == 0
            let tickLength = clockWidth * CGFloat(isMajor ? majorLength : minorLength)
            let progress = Double(i) / 60.0
            let angle = CGFloat(-(progress * M_PI * 2) + M_PI_2)
            
            let tickColor = isMajor ? majorColor : minorColor
            tickColor.setStroke()
            
            let tickPath = NSBezierPath()
            tickPath.move(to: CGPoint(
                x: center.x + cos(angle) * (tickRadius - tickLength),
                y: center.y + sin(angle) * (tickRadius - tickLength)
            ))
            
            tickPath.line(to: CGPoint(
                x: center.x + cos(angle) * tickRadius,
                y: center.y + sin(angle) * tickRadius
            ))
            
            tickPath.lineWidth = CGFloat(ceil(Double(clockWidth) * (isMajor ? majorThickness : minorThickness)))
            tickPath.stroke()
            }
        }
    }
    
//    func drawNumbers(fontSize: CGFloat, radius: Double) {
//        let center = CGPoint(x: clockFrame.midX, y: clockFrame.midY)
//        let clockWidth = clockFrame.size.width
//        let textRadius = clockWidth * CGFloat(radius)
//        let font = NSFont(name: "HelveticaNeue-Light", size: clockWidth * fontSize)!
//        for i in 0..<12 {
//            let string = NSAttributedString(string: "\(12 - i)", attributes: [
//                NSForegroundColorAttributeName: NSColor.black,
//                NSKernAttributeName: -2,
//                NSFontAttributeName: font
//                ])
//            
//            let stringSize = string.size()
//            let angle = CGFloat((Double(i) / 12.0 * M_PI * 2.0) + M_PI_2)
//            let rect = CGRect(
//                x: (center.x + cos(angle) * (textRadius - (stringSize.width / 2.0))) - (stringSize.width / 2.0),
//                y: center.y + sin(angle) * (textRadius - (stringSize.height / 2.0)) - (stringSize.height / 2.0),
//                width: stringSize.width,
//                height: stringSize.height
//            )
//            
//            string.draw(in: rect)
//        }
//    }
    
    
    func drawTime(components:
        DateComponents, hours: Double, minutes: Double, seconds: Double) {
        drawHours(angle: -(M_PI * 2.0 * hours) + M_PI_2)
        drawMinutes(angle: -(M_PI * 2.0 * minutes) + M_PI_2)
        if(showSecondHand){
            drawSeconds(angle: -(M_PI * 2.0 * seconds) + M_PI_2)
        }
    }
    
    func drawHours(angle: Double) {
        NSColor.black.setStroke()
        drawHand(length: 0.263955343, thickness: 0.023125997, angle: angle)
    }
    
    func drawMinutes(angle: Double) {
        NSColor.black.setStroke()
        drawHand(length: 0.391547049, thickness: 0.014354067, angle: angle)
    }
    
    func drawSeconds(angle: Double) {
        NSColor.red.setStroke()
        drawHand(length: 0.391547049, thickness: 0.009569378, angle: angle)
        
        // Counterweight
        //        drawHand(length: -0.076555024, thickness: 0.028708134, angle: angle, lineCapStyle: NSLineCapStyle.roundLineCapStyle)
        NSColor.red.setFill()

        let nubSize = clockFrame.size.width * 0.052631579
        let nubFrame = CGRect(x: (bounds.size.width - nubSize) / 2.0, y: (bounds.size.height - nubSize) / 2.0, width: nubSize, height: nubSize)
                NSBezierPath(ovalIn: nubFrame).fill()
        
        // Screw
        let dotSize = clockFrame.size.width * 0.006379585
        NSColor.red.setFill()
        let screwFrame = CGRect(x: (bounds.size.width - dotSize) / 2.0, y: (bounds.size.height - dotSize) / 2.0, width: dotSize, height: dotSize)
        let screwPath = NSBezierPath(ovalIn: screwFrame)
                screwPath.fill()
    }
    
    
    // MARK: - Drawing Helpers
    func drawHand(length: Double, thickness: Double, angle: Double, lineCapStyle: NSLineCapStyle = NSLineCapStyle.squareLineCapStyle) {
        let center = CGPoint(x: clockFrame.midX, y: clockFrame.midY)
        let clockWidth = Double(clockFrame.size.width)
        let end = CGPoint(
            x: Double(center.x) + cos(angle) * clockWidth * length,
            y: Double(center.y) + sin(angle) * clockWidth * length
        )
        
        let path = NSBezierPath()
        path.lineWidth = CGFloat(clockWidth * thickness)
        path.lineCapStyle = lineCapStyle
        path.move(to: center)
        path.line(to: end)
        path.stroke()
    }
    
}
