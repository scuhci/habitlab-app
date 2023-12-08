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


// MARK: - Schedule Name List
/*extension DeviceActivityName {
    static let daily = Self("daily")
}*/

// MARK: - MAnagedSettingsStore List

private let _MyModel = MyModel()

class MyModel: ObservableObject {
    // Import ManagedSettings to get access to the application shield restriction
    let store = ManagedSettingsStore(named: .daily)
    var shieldSettings = ShieldConfiguration(title: ShieldConfiguration.Label(text: "Habitlab", color: UIColor.blue))
    //@EnvironmentObject var store: ManagedSettingsStore
    
    @Published var selectionToDiscourage: FamilyActivitySelection
    
    init() {
        selectionToDiscourage = FamilyActivitySelection()
    }
    
    class var shared: MyModel {
        return _MyModel
    }
    
    func setShieldRestrictions() {
        //Check if app usage is over 10 mins before restricting
        

        // Pull the selection out of the app's model and configure the application shield restriction accordingly
        let applications = MyModel.shared.selectionToDiscourage
        
        store.shield.applications = applications.applicationTokens.isEmpty ? nil : applications.applicationTokens
        store.shield.applicationCategories = applications.categoryTokens.isEmpty
        ? nil
        : ShieldSettings.ActivityCategoryPolicy.specific(applications.categoryTokens)
    }

    func turnOffShieldRestrictions() {
        store.shield.applications = nil
        store.shield.applicationCategories = nil
    }
    
}
