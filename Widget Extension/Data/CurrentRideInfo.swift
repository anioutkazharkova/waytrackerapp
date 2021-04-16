//
//  CurrentRideInfo.swift
//  WayTrackerApp
//
//  Created by Anna Zharkova on 10.04.2021.
//

import Foundation

struct CurrentRideInfo {
    let rideId: Int
    let bykeId: String
    let bykeNumber: String
    let startParkingId: String
    let startParkingAddress: String
    let rideStart: Date?
    let timeLimit: Int
    let cost: String
    var location: String = ""
    var image: Data = Data()
    let url: String?
    
    var time: String {
        let currentTime = Date()
        if let start = rideStart {
            let diff = Int(currentTime.timeIntervalSince1970 - start.timeIntervalSince1970)
            return diff.stringPureTime
        }
        return "00:00"
    }
}
