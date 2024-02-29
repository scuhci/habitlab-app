//
//  ContentView.swift
//  HabitLab App
//
//  Created by Husain Unwalla on 6/6/23.
//

import SwiftUI
import FamilyControls
import DeviceActivity
import ManagedSettings

struct ContentView: View {
    @State private var isDiscouragedPresented = false
    @State private var date = Date()
    @EnvironmentObject var model: MyModel
    
    var body: some View {
        let center = AuthorizationCenter.shared
        VStack(alignment: .leading) {
            LandingView()
        }
        .onAppear{
            Task{
                do{
                    try await center.requestAuthorization(for: .individual)
                } catch{
                    print ("Failed to enroll for FamilyControl .\(error)" )
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MyModel())
    }
}
