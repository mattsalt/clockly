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
        var clockItems:[ClockItem] = []

        if let context = (NSApplication.shared().delegate as? AppDelegate)?.managedObjectContext{
            do {
                let dataFetchRequest: NSFetchRequest<NSFetchRequestResult> = ClockItem.fetchRequest()
                clockItems = try context.fetch(dataFetchRequest) as! [ClockItem]
                for item in clockItems {
                    clocks.append(Clock(timeZone: TimeZone(abbreviation: item.abbreviation!)!, displayName: item.displayName!)!)
                }
            }catch{}
        }
        return clocks
    }
    
    static func addClock(clock:Clock){
        
    }
    
    static func deleteClock(){
        
    }
    
}
