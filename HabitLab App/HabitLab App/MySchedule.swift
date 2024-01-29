import Foundation
import DeviceActivity
import UserNotifications

// The Device Activity name is how I can reference the activity from within my extension
extension DeviceActivityName {
    // Set the name of the activity to "daily"
    static let daily = Self("daily")
}

extension DeviceActivityEvent.Name {
    // Set the name of the event to "discouraged"
    static let discouraged = Self("discouraged")
}


class MySchedule {
    static public func setSchedule() {
        print("Setting schedule...")
        //print(MyModel.shared.minutes)
        let events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [
            .discouraged: DeviceActivityEvent(
                applications: MyModel.shared.selectionToDiscourage.applicationTokens,
                threshold: DateComponents(hour:0, minute:1)
            )
        ]
        
        // Create a Device Activity center
        let center = DeviceActivityCenter()
        do {
            print("Try to start monitoring...")
            // Call startMonitoring with the activity name, schedule, and events
            try center.startMonitoring(.daily, during: schedule, events: events)
        } catch {
            print("Error monitoring schedule: ", error)
        }
    }
}
// Another ingredient to shielding apps is figuring out what the guardian wants to discourage
// The Family Controls framework has a SwiftUI element for this: the family activity picker
