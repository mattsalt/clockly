//
//  Clock.swift
//  TableTest
//
//  Created by Matthew on 02/03/2017.
//  Copyright © 2017 Matthew. All rights reserved.
//

import Foundation

class Clock: NSObject {
    
    var timeZone:TimeZone
    var displayName:String
    
    //MARK: Initialisation
    init?(timeZone: TimeZone, displayName:String){
        self.timeZone = timeZone
        self.displayName = displayName
        super.init()
    }
    
}
