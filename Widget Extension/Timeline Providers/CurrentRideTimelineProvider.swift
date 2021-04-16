//
//  CurrentRideTimelineProvider.swift
//  WayTrackerApp
//
//  Created by Anna Zharkova on 10.04.2021.
//

import Foundation
import WidgetKit


struct CurrentRideTimelineProvider: TimelineProvider {

    typealias Entry = CurrentRideEntry

    func placeholder(in context: Context) -> Entry {
        let entry = RideLoader.shared.currentRide ?? RideLoader.shared.emptyCurrentRide
       return Entry(date: Date(), ride: entry)
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
        let entry = RideLoader.shared.currentRide ?? RideLoader.shared.emptyCurrentRide
        completion(Entry(date: Date(), ride: entry))
    }

   func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    let isEmpty = RideLoader.shared.currentRide == nil
    let ride = RideLoader.shared.currentRide ?? RideLoader.shared.emptyCurrentRide
     RideLoader.shared.getCurrentRide()
    let refreshDate = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
    RideLoader.shared.previousDate = Date()
        completion(Timeline(entries: [Entry(date: Date(), ride: ride)], policy: .after(refreshDate)))
        }
}

