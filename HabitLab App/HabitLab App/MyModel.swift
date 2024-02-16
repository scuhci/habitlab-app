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

// The Device Activity name is how I can reference the activity from within my extension
extension DeviceActivityName {
    // Set the name of the activity to "daily"
    static let daily = Self("daily")
}

extension DeviceActivityEvent.Name {
    // Set the name of the event to "discouraged"
    static let discouraged = Self("discouraged")
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
    var shieldSettings = ShieldConfiguration(title: ShieldConfiguration.Label(text: "Habitlab", color: UIColor.blue));
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
        print("Setting restriction..")
        // Pull the selection out of the app's model and configure the application shield restriction accordingly
        let applications = MyModel.shared.selectionToDiscourage
        limitedStore.shield.applications = applications.applicationTokens.isEmpty ? nil : applications.applicationTokens
        limitedStore.shield.applicationCategories = applications.categoryTokens.isEmpty
        ? nil
        : ShieldSettings.ActivityCategoryPolicy.specific(applications.categoryTokens)
    }
    
    func storeEncodedData<T: Encodable>(data: T, key: String, suiteName: String? = nil) {
      do {
        let encoder = JSONEncoder()
        let encodedData = try encoder.encode(data)
        let jsonString = String(data: encodedData, encoding: .utf8)!
        var userDefaults: UserDefaults!
        if let suiteName = suiteName {
          userDefaults = UserDefaults(suiteName: suiteName)
        } else {
          userDefaults = UserDefaults.standard
        }
        userDefaults.set(jsonString, forKey: key)
        userDefaults.synchronize()
        print("Data encoded and stored successfully under key: \(key)")
      } catch {
        print("Error encoding and storing data: \(error)")
      }
    }
    
    public func setSchedule() {
        print("Setting schedule...")
        let event = DeviceActivityEvent(
                applications: MyModel.shared.selectionToDiscourage.applicationTokens,
                categories: MyModel.shared.selectionToDiscourage.categoryTokens,
                threshold: DateComponents(second:1)
            )
        let encoder = JSONEncoder()
          do {
            let data = try encoder.encode(MyModel.shared.selectionToDiscourage.categoryTokens)
            let jsonString = String(data: data, encoding: .utf8)!
            let sharedUserDefaults = UserDefaults(suiteName: "group.com.name.habitlab")
            sharedUserDefaults?.set(jsonString, forKey: "selectedAppCategories")
            sharedUserDefaults?.synchronize()
            print("Tokens encoded")
          } catch {
            print("Error encoding tokens: \(error)")
          }
        
        // Create a Device Activity center
        let center = DeviceActivityCenter()
        do {
            print("Try to start monitoring...")
            // Call startMonitoring with the activity name, schedule, and events
            try center.startMonitoring(.daily, 
                                       during: schedule,
                                       events:[.discouraged: event] )
        } catch {
            print("Error monitoring schedule: ", error)
        }
    }
    
}
