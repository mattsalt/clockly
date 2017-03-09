//
//  ClockManager.swift
//  Clockly
//
//  Created by Matthew on 06/03/2017.
//  Copyright © 2017 Matthew. All rights reserved.
//

import Foundation
import Cocoa

class ClockManager {

    static func getClocks() -> [Clock]{
        var clocks:[Clock] = []

        if let context = (NSApplication.shared().delegate as? AppDelegate)?.managedObjectContext{
            do {
                let dataFetchRequest: NSFetchRequest<NSFetchRequestResult> = Clock.fetchRequest()
                clocks = try context.fetch(dataFetchRequest) as! [Clock]
            }catch{}
        }
        return clocks.sorted { (c1, c2) -> Bool in
            c1.position < c2.position
        }
    }
    
    static func addClock(abbreviation:String, displayName:String, position:Int){
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.managedObjectContext {
            let clock = Clock(context: context)
            clock.displayName = displayName
            clock.abbreviation = abbreviation
            clock.position = Int32(position)
            (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
        }
    }
    
    static func deleteClock(clock:Clock){
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.managedObjectContext{
                context.delete(clock)
                (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
        }
    }
    
}
