//
//  PopoverBackgroundView.swift
//  Clockly
//  Subcass of NSView used to configure the popover view.
//
//  Created by Matthew on 06/03/2017.
//  Copyright © 2017 Matthew. All rights reserved.
//


import Cocoa

class PopoverBackgroundView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    override func viewDidMoveToWindow() {
//        
//        guard let frameView = window?.contentView?.superview else {
//            return
//        }
////        
//        let backgroundView = NSView(frame: frameView.bounds)
//        backgroundView.wantsLayer = true
//        backgroundView.layer?.backgroundColor = CGColor.init(gray: 0.75, alpha: 1.0) // colour of your choice
//        backgroundView.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
//        frameView.addSubview(backgroundView, positioned: .below, relativeTo: frameView)
        
    }
}
