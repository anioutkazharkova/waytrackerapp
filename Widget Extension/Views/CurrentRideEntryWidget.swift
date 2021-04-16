//
//  CurrentRideEntryWidget.swift
//  WayTrackerAppWidgetExtension
//
//  Created by Anna Zharkova on 11.04.2021.
//

import Foundation
import SwiftUI
import Kingfisher
struct CurrentRideWidgetEntryView: View {
    var entry: CurrentRideTimelineProvider.Entry
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Active ride: now").foregroundColor(.white).font(.system(size: 14)).bold()
                        Text("Address: \(entry.ride.startParkingAddress)").foregroundColor(.white).font(.system(size: 18))
                        HStack (spacing: 20) {
                            VStack(alignment: .leading) {
                                Text("Byke:")
                                    .foregroundColor(.white).font(.system(size: 18))
                                Text("\(entry.ride.bykeNumber)")
                                    .foregroundColor(.white).font(.system(size: 16)).bold()
                            }
                            VStack {
                                Text("Time:").foregroundColor(.white).font(.system(size: 18))
                                Text("\(entry.ride.time)").foregroundColor(.white).font(.system(size: 16)).bold()
                            }
                            VStack {
                                Text("Current cost:")
                                    .foregroundColor(.white).font(.system(size: 18))
                                Text("\(entry.ride.cost)")
                                    .foregroundColor(.white).font(.system(size: 16)).bold()
                            }
                        }
                        Text("Location: \(entry.ride.location)").foregroundColor(.white).font(.system(size: 18))
                    }.padding(10)
                    Divider().background(Color.white).frame(height: 1)
                    Image(uiImage: UIImage(data: entry.ride.image) ?? UIImage()).frame(width: geometry.size.width, height: 200,alignment: .bottom)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue)
            }
        }
    }
}
