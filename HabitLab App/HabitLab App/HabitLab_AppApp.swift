//
//  HabitLab_AppApp.swift
//  HabitLab App
//
//  Created by Husain Unwalla on 6/6/23.
//

import SwiftUI
import FamilyControls
import ManagedSettings
import DeviceActivity

@main
struct HabitLab_AppApp: App {
    
    @StateObject var model = MyModel.shared
    @StateObject var store = ManagedSettingsStore()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .environmentObject(store)
        }
    }
}
