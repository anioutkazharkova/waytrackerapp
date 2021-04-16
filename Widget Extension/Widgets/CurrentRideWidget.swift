//
//  CurrentRideWidget.swift
//  WayTrackerAppWidgetExtension
//
//  Created by Anna Zharkova on 16.04.2021.
//

import Foundation
import WidgetKit
import SwiftUI

struct CurrentRideWidget: Widget {

    let kind: String = "CurrentRideWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CurrentRideTimelineProvider()) { entry in
            CurrentRideWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Current Ride Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemLarge])
    }

}
