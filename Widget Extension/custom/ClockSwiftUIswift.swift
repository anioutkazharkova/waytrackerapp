//
//  ClockSwiftUIswift.swift
//  WayTrackerApp
//
//  Created by Anna Zharkova on 11.04.2021.
//

import SwiftUI

struct ClockSwiftUIswift: UIViewRepresentable {
    func makeUIView(context: Context) -> ClockView {
        return ClockView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    }
    
    func updateUIView(_ uiView: ClockView, context: Context) {
        
    }
    
    typealias UIViewType = ClockView
    
}
