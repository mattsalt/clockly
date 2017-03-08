//
//  TestView.swift
//  Clockly
//
//  Created by Matthew on 08/03/2017.
//  Copyright © 2017 Matthew. All rights reserved.
//

import Cocoa

class TestView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.white.setFill()
        NSRectFill(dirtyRect)
    }

    
}
