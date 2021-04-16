//
//  LastRideTimelineProvider.swift
//  WayTrackerAppWidgetExtension
//
//  Created by Anna Zharkova on 10.04.2021.
//

import Foundation
import WidgetKit

struct LastRideTimelineProvider: TimelineProvider {

    typealias Entry = RideEntry

    func placeholder(in context: Context) -> Entry {
        let entry = RideLoader.shared.emptyRide
       return Entry(date: Date(), ride: entry)
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
        let entry = RideLoader.shared.emptyRide
        completion(Entry(date: Date(), ride: entry))
    }

   func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    let isEmpty = RideLoader.shared.lastSavedRide == nil
    let ride = RideLoader.shared.lastSavedRide ?? RideLoader.shared.emptyRide
    RideLoader.shared.getRide()
    let refreshDate = Calendar.current.date(byAdding: .minute, value: 10, to: RideLoader.shared.previousDate)!
    RideLoader.shared.previousDate = Date()
        completion(Timeline(entries: [Entry(date: Date(), ride: ride)], policy: .after(refreshDate)))
        }
}
