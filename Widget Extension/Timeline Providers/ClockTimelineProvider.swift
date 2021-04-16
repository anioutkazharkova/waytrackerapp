//
//  ClockTimelineProvider.swift
//  WayTrackerAppWidgetExtension
//
//  Created by Anna Zharkova on 11.04.2021.
//

import Foundation
import WidgetKit

class TimeHolder {
    var timer: Timer? = nil
    var currentTime: Date = Date()
    
    static let shared = TimeHolder()
    
    init() {
        self.timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    @objc func update() {
        self.currentTime = Date()
        WidgetCenter.shared.reloadTimelines(ofKind: "Clock")
    }
}

struct ClockTimelineProvider: TimelineProvider {

    typealias Entry = ClockEntry

    func placeholder(in context: Context) -> Entry {
       return Entry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
        completion(Entry(date: Date()))
    }

   func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
   let current = Date()
    let refreshDate = Calendar.current.date(byAdding: .minute, value: 1, to: current)!
   
    completion(Timeline(entries: [Entry(date: current)], policy: .after(refreshDate)))
   }
}

