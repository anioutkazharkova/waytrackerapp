//
//  LastRideWidget.swift
//  WayTrackerAppWidgetExtension
//
//  Created by Anna Zharkova on 10.04.2021.
//

import SwiftUI
import WidgetKit

struct LastRideWidget: Widget {

    let kind: String = "LastRideWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: LastRideTimelineProvider()) { entry in
            RideMapWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Last Ride Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemLarge])
    }

}

