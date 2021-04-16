//
//  RideLoader.swift
//  WayTrackerAppWidgetExtension
//
//  Created by Anna Zharkova on 10.04.2021.
//

import Foundation
import WidgetKit

class RideLoader: LocationListener {
    static let shared = RideLoader()
    private lazy var urlSession: URLSession = {
        return URLSession(configuration: .default)
    }()
    var previousDate = Date()
    
    private var sessionTask: URLSessionDataTask? = nil
    
    var lastSavedRide: LastRideInfo? = nil
    var currentRide: CurrentRideInfo? = nil
    var previousRide: CurrentRideInfo? = nil
    
    var location: Location? = nil
    
    func getRide() {
        if lastSavedRide == nil {
            lastSavedRide = emptyRide
        }
        RideLoader.shared.lastRide {(result: Result<LastRideInfo, Error>) in
            switch result {
            case .success(var ride):
                if ride.rideId != self.lastSavedRide?.rideId {
                self.lastSavedRide = ride
                //WidgetCenter.shared.reloadTimelines(ofKind: "LastRideWidget")
                self.loadImage(url: ride.url) { (imageResult) in
                    switch imageResult {
                    case .success(let data):
                        ride.image = data
                        self.lastSavedRide = ride
                        WidgetCenter.shared.reloadTimelines(ofKind: "LastRideWidget")
                    default:
                        break
                    }
                }
                }else {
                    WidgetCenter.shared.reloadTimelines(ofKind: "LastRideWidget")
                }
            default:
                break
            }
        }
    }
    
    func getCurrentRide() {
        if currentRide == nil {
            currentRide = emptyCurrentRide
        }
        RideLoader.shared.fakeCurrentRide {(result: Result<CurrentRideInfo, Error>) in
            switch result {
            case .success(let ride):
                self.currentRide = ride
                //WidgetCenter.shared.reloadTimelines(ofKind: "CurrentRideWidget")
                DispatchQueue.main.async {
                    LocationManager.shared.addDelegate(delegate: self)
                    LocationManager.shared.startUpdate()
                }
                //WidgetCenter.shared.reloadTimelines(ofKind: "LastRideWidget")
                /*self.loadImage(url: ride.url) { (imageResult) in
                    switch imageResult {
                    case .success(let data):
                        ride.image = data
                        self.currentRide = ride
                        WidgetCenter.shared.reloadTimelines(ofKind: "LastRideWidget")
                    default:
                        break
                    }
                }*/
            
            default:
                break
            }
        }
    }
    
    
    func lastRide(completion: @escaping (Result<LastRideInfo, Error>) -> Void) {
        let ride = LastRideInfo(rideId: 23, bykeId: "0025", bykeNumber: "0025", startParkingId: "43", endParkingId: "67", startParkingAddress: "Georgieva, st", endParkingAddress: "Malakhova, st 128", rideStart: "08.04.2021 12:15".toDate(), rideEnd: "08.04.2021 12:47".toDate(), timeLimit: 1200, cost: "50 ₽")
        return completion(.success(ride))
    }
    
    func fakeCurrentRide(completion: @escaping (Result<CurrentRideInfo, Error>) -> Void) {
        let ride = CurrentRideInfo(rideId: 12, bykeId: "0027", bykeNumber: "0027", startParkingId: "43", startParkingAddress: "Georgieva, st", rideStart: "10.04.2021 19:45".toDate(), timeLimit: 1200, cost: "250 ₽", url: "https://maps.googleapis.com/maps/api/staticmap?size=340x200&markers=icon:http://192.168.1.194/public/images/r-pin-icon.png|size:mid|53.347452, 83.685838&markers=color:red|size:mid&maptype=roadmap&sensor=false&key=AIzaSyBOmw4NBRo4VkR7SRR1-O1jUejTo26I4rg")
        return completion(.success(ride))
    }
    
    var emptyRide: LastRideInfo {
        return  LastRideInfo(rideId: 0, bykeId: "--", bykeNumber: "--", startParkingId: "--", endParkingId: "--", startParkingAddress: "-", endParkingAddress: "--", rideStart: "--".toDate(), rideEnd: "--".toDate(), timeLimit: 0, cost: "--")
    }
    
    var emptyCurrentRide: CurrentRideInfo {
        return  CurrentRideInfo(rideId: 0, bykeId: "--", bykeNumber: "--", startParkingId: "--", startParkingAddress: "-",rideStart: "--".toDate(),  timeLimit: 0, cost: "--", url:"")
    }
    
    func loadImage(url: String, completion: @escaping(Result<Data,Error>)->Void) {
        guard let urlPath = URL(string: url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) ?? "") else {return}
    let request = URLRequest(url: urlPath)
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            self.sessionTask = self.urlSession.dataTask(with: request, completionHandler: {(data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        completion(.success(data))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(error!))
                    }
                }
            })
            
            self.sessionTask?.resume()
        }
    }
    
    func changedLocation(location: Location) {
        if location != self.location {
            self.location = location
            self.currentRide?.location = String(format: "%.4f %.4f", 53.347452, 83.685838)
            let url = "https://maps.googleapis.com/maps/api/staticmap?size=340x200&markers=icon:http://192.168.1.194/public/images/r-pin-icon.png|size:mid|53.347452, 83.685838&markers=color:red|size:mid&maptype=roadmap&sensor=false&key=AIzaSyBOmw4NBRo4VkR7SRR1-O1jUejTo26I4rg"
            WidgetCenter.shared.reloadTimelines(ofKind: "CurrentRideWidget")
            self.loadImage(url: url) { [weak self] (result) in
                guard let self = self else {return}
                switch result {
                case .success(let data):
                    self.currentRide?.image = data
                    WidgetCenter.shared.reloadTimelines(ofKind: "CurrentRideWidget")
                    self.previousRide = self.currentRide
                default:
                    break
                }
            }
        }else {
            self.currentRide?.location =  String(format: "%.4f %.4f", 53.347452, 83.685838)
            self.currentRide?.image = self.previousRide?.image ?? Data()
            WidgetCenter.shared.reloadTimelines(ofKind: "CurrentRideWidget")
        }
    }
}

extension String {
    func toDate()->Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
    let date = dateFormatter.date(from: self)
        return date ?? Date()
    }
}
