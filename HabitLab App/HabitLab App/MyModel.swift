//
//  MyModel.swift
//  HabitLab App
//
//  Created by Husain Unwalla on 6/6/23.
//

import Foundation
import FamilyControls
import ManagedSettings
import ManagedSettingsUI
import SwiftUI
import DeviceActivity

private let _MyModel = MyModel()

extension DeviceActivityName {
    static let daily = Self("daily")
}

extension ManagedSettingsStore.Name {
    static let limited = Self("limited")
}

extension DeviceActivityEvent.Name {
    // Set the name of the event to "encouraged"
    static let discouraged = Self("discouraged")
}

class MyModel: ObservableObject {
    // Import ManagedSettings to get access to the application shield restriction
    let limitedStore = ManagedSettingsStore(named: .limited)
    
    // Import ManagedSettings to get access to the application shield restriction
    var shieldSettings = ShieldConfiguration(title: ShieldConfiguration.Label(text: "Habitlab", color: UIColor.blue))
    @Published var selectionToDiscourage: FamilyActivitySelection
    @State var hours: Int = 0
    @State var minutes: Int = 0
    
    init() {
        selectionToDiscourage = FamilyActivitySelection()
    }
    
    class var shared: MyModel {
        return _MyModel
    }
    
    //Called when familyActivityPicker selections change
    func setShieldRestrictions() {
        // Pull the selection out of the app's model and configure the application shield restriction accordingly
        let applications = MyModel.shared.selectionToDiscourage
        
        limitedStore.shield.applications = applications.applicationTokens.isEmpty ? nil : applications.applicationTokens
        limitedStore.shield.applicationCategories = applications.categoryTokens.isEmpty
        ? nil
        : ShieldSettings.ActivityCategoryPolicy.specific(applications.categoryTokens)
    }

    func setSchedule() {
        // Scheudle During which the Activity runs
        // This Schedule runs daily
        let schedule = DeviceActivitySchedule(
            // Set Schedule hours to reset at mudnight
            intervalStart: DateComponents(hour: 0, minute: 1),
            intervalEnd: DateComponents(hour: 23, minute: 59),
            // I've also set the schedule to repeat
            repeats: true
        )
        print("Setting schedule...")
        print($hours)
        let events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [
            .discouraged: DeviceActivityEvent(
                applications: MyModel.shared.selectionToDiscourage.applicationTokens,
                threshold: DateComponents(second: 10)
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
