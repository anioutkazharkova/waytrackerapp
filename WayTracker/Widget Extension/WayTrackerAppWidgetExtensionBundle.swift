import SwiftUI
import WidgetKit

@main
struct WayTrackerAppWidgetExtensionBundle: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        RideWidget()
        ListWidget()
    }

}
