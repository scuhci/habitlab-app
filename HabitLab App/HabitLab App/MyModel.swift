import Foundation
import FamilyControls
import ManagedSettings
import ManagedSettingsUI
import SwiftUI
import DeviceActivity

private let _MyModel = MyModel()

extension ManagedSettingsStore.Name {
    static let limited = Self("limited")
}

// Scheudle During which the Activity runs
// This Schedule runs daily
let schedule = DeviceActivitySchedule(
    // Set Schedule hours to reset at mudnight
    intervalStart: DateComponents(hour: 0, minute: 1),
    intervalEnd: DateComponents(hour: 23, minute: 59),
    // I've also set the schedule to repeat
    repeats: true
)

class MyModel: ObservableObject {
    // Import ManagedSettings to get access to the application shield restriction
    let limitedStore = ManagedSettingsStore(named: .limited)
    
    // Import ManagedSettings to get access to the application shield restriction
    var shieldSettings = ShieldConfiguration(title: ShieldConfiguration.Label(text: "Habitlab", color: UIColor.blue))
    @Published var selectionToDiscourage: FamilyActivitySelection
    @Published var hours: Int = 0
    @Published var minutes: Int = 0
    
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
    
}
