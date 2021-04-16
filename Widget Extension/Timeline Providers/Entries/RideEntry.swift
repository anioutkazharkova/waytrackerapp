//
//  RideEntry.swift
//  WayTrackerAppWidgetExtension
//
//  Created by Anna Zharkova on 10.04.2021.
//

import Foundation
import WidgetKit

struct RideEntry: TimelineEntry {
    var date: Date
    
    let ride: LastRideInfo
}


struct CurrentRideEntry: TimelineEntry {
    var date: Date
    
    let ride: CurrentRideInfo
}

struct ClockEntry: TimelineEntry {
    var date: Date
}
