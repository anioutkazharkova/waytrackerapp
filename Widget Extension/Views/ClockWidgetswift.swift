//
//  ClockWidgetswift.swift
//  WayTrackerAppWidgetExtension
//
//  Created by Anna Zharkova on 11.04.2021.
//

import SwiftUI
import UIKit

struct ClockWidgetswift: View {
    var entry: ClockTimelineProvider.Entry
    var body: some View {
        GeometryReader {geometry in
            let frame = CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height)
            Image(uiImage: ClockView(frame: frame).asImage(rect: frame))
        }
    }
}


extension UIView {
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
