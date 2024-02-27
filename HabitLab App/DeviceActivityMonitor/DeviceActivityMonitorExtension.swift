//
//  DeviceActivityMonitorExtension.swift
//  DeviceActivityMonitor
//
//  Created by Husain Unwalla on 12/8/23.
//

import DeviceActivity
import ManagedSettings
import SwiftUI

// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        
        // Handle the start of the interval.
        let limitedStore = ManagedSettingsStore(named: .limited)
        limitedStore.clearAllSettings()
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        // Handle the end of the interval.
        
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
        let categoriesToShield:Set<ActivityCategoryToken>;
        let applicationsToShield:Set<ApplicationToken>;
        
        let limitedStore = ManagedSettingsStore(named: .limited)
        let sharedUserDefaults = UserDefaults(suiteName: "group.com.name.habitlab")
        guard let categoryTokensJsonString = sharedUserDefaults?.string(forKey: "selectedAppCategories") else {return}
        guard let applicationTokensJsonString = sharedUserDefaults?.string(forKey: "selectedApps") else {return}
        let decoder = JSONDecoder()
        do {
            let categoryTokens = Data(categoryTokensJsonString.utf8)
            let applicationTokens = Data(applicationTokensJsonString.utf8)
            
            applicationsToShield = try decoder.decode(Set<ApplicationToken>.self, from: applicationTokens)
            categoriesToShield =  try decoder.decode(Set<ActivityCategoryToken>.self, from: categoryTokens)
            limitedStore.shield.applicationCategories = .specific(categoriesToShield)
            //limitedStore.shield.applications = .specific(applicationsToShield)
        } catch {
            print("Error decoding tokens: \(error)")
        }
    }
    
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
        
        // Handle the warning before the interval starts.
    }
    
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
        
        // Handle the warning before the interval ends.
    }
    
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        
        // Handle the warning before the event reaches its threshold.
    }
}
