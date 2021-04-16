//
//  RideInfo.swift
//  WayTrackerApp
//
//  Created by Anna Zharkova on 10.04.2021.
//

import Foundation

struct LastRideInfo {
    let rideId: Int
    let bykeId: String
    let bykeNumber: String
    let startParkingId: String
    let endParkingId: String
    let startParkingAddress: String
    let endParkingAddress: String
    let rideStart: Date?
    let rideEnd: Date?
    let timeLimit: Int
    let cost: String
    let url: String = "https://maps.googleapis.com/maps/api/staticmap?size=340x200&path=color:0xff0000ff|weight:5|53.347452, 83.685838 |53.347856, 83.685656|53.347964, 83.685742|53.349226, 83.690624|53.349405, 83.690838|53.350161, 83.691021|53.349322, 83.690742|53.349962, 83.691021|53.350646, 83.691138|53.350888, 83.692631|53.350632, 83.695839|53.350433, 83.697073|53.348563, 83.696687|53.344772, 83.695796|53.343331, 83.695045|53.343875, 83.694906&key=AIzaSyBOmw4NBRo4VkR7SRR1-O1jUejTo26I4rg"
    var image: Data = Data()
    
    mutating func setupImage(image: Data){
        self.image = image
    }
    
    var isOverTimed: Bool {
        if let start = rideStart {
            let limitDate = start.adding(minutes: timeLimit)
            let currentDate = Date()
            return currentDate < limitDate
        }
        return false
    }
    
    var timeFromCurrent: String {
        let currentTime = Date()
        if let start = rideStart {
            let diff = Int(currentTime.timeIntervalSince1970 - start.timeIntervalSince1970)
            return diff.stringPureTime
        }
        return "00:00"
    }
    
    var time: String {
        if let start = rideStart, let last = rideEnd {
            let diff = Int(last.timeIntervalSince1970 - start.timeIntervalSince1970)
            return diff.stringPureTime
        }
        return "00:00"
    }
}

extension Date {
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
  
    }
}

extension Int {
    var stringPureTime: String {
        let difference = self
        let hours = difference / 3600
        let minutes = (difference / 60 ) % 60
        let seconds = difference % 60
        let d = (difference / 86400)
        
        var dayString = "00:00"
        
        if d > 0 {
            dayString = " \(d) d"
        } else {
        
        if hours > 0 {
            dayString = " \(hours)h \(minutes)m"
        } else if minutes != 0 {
            dayString = String(format: "%02d:%02d", minutes,seconds)
        }
        }
        return dayString
    }
}
