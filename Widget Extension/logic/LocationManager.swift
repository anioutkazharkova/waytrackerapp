//
//  LocationManager.swift
//  WayTrackerApp
//
//  Created by Anna Zharkova on 10.04.2021.
//

import Foundation
import Foundation
import CoreLocation
import WidgetKit

struct Location: Codable, Equatable {
    var latitude: Double
    var longitude: Double

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

struct LocationWithAddress: Codable {
    var latitude: Double
    var longitude: Double
    var address: String
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager
    var currentLocation: Location?
    private var isSetup: Bool = false

    private var listeners: [LocationListener] = [LocationListener]()

    var status: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }

    static let shared = LocationManager()
    override private init() {
        self.locationManager = CLLocationManager()

    }

    func request() {
        self.locationManager.requestAlwaysAuthorization()
    }

    func addDelegate(delegate: LocationListener) {
        if (listeners.filter {$0.type == delegate.type}).first == nil {
            listeners.append(delegate)
            return
        }
    }

    func removeDelegate(delegate: LocationListener) {
        var index = -1
        for i in 0..<listeners.count {
            if listeners[i].type == delegate.type {
                index = i
                break
            }
        }
        listeners.remove(at: index)
    }

    func setupLocationManager() {
        isSetup = true
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.allowsBackgroundLocationUpdates = false
        self.locationManager.activityType = .other
        locationManager.distanceFilter = kCLDistanceFilterNone
      //  self.locationManager.allowDeferredLocationUpdates(untilTraveled: CLLocationDistanceMax, timeout: CLTimeIntervalMax)
    }

    func startUpdate() {
        if !isSetup {
            self.setupLocationManager()
        }
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
       // self.locationManager.startMonitoringSignificantLocationChanges()
    }

    func stopUpdate() {
        self.locationManager.stopUpdatingLocation()
        self.locationManager.delegate = nil
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            currentLocation = Location(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
            for delegate in listeners {
                delegate.changedLocation(location: currentLocation!)
            }
           // stopUpdate()

        }
    }

    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        self.locationManager.startMonitoringSignificantLocationChanges()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedAlways || status == CLAuthorizationStatus.authorizedWhenInUse{
            startUpdate()
        } else {
            self.locationManager.requestAlwaysAuthorization()
        }
    }
}

protocol LocationListener: class {
    func changedLocation(location: Location)

}

extension LocationListener {
    var type: String {
        return String(describing: self)
    }
}
