//
//  ClockWidget.swift
//  WayTrackerAppWidgetExtension
//
//  Created by Anna Zharkova on 16.04.2021.
//

import Foundation
import SwiftUI
import WidgetKit

struct ClockWidget: Widget {

    let kind: String = "Clock"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ClockTimelineProvider()) { entry in
            ClockWidgetswift(entry: entry)
        }
        .configurationDisplayName("Current Ride Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemLarge])
    }

}
