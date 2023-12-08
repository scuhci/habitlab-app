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

struct ExampleView: View {
    @EnvironmentObject var model: MyModel

    public var body: some View {
        VStack {
        }
    }
}


struct ContentView: View {
    @State private var isDiscouragedPresented = false
    @State private var date = Date()
    @EnvironmentObject var model: MyModel
    
    var body: some View {
        let center = AuthorizationCenter.shared
        VStack {
            Text("Setlect apps to set a daily limit")
            Button("Add limit") {
                isDiscouragedPresented = true
            }
            .buttonStyle(.bordered)
            .familyActivityPicker(isPresented: $isDiscouragedPresented, selection: $model.selectionToDiscourage)
            .onSubmit {
                print("test 1");
            }
        }
        .onChange(of: model.selectionToDiscourage) { newSelection in
            //MyModel.shared.setShieldRestrictions()
        }.onAppear{
            Task{
                do{
                    try await center.requestAuthorization(for: .individual)
                } catch{
                    print ("Failed to enroll for FamilyControl .\(error)" )
                }
            }
        }
        DatePicker(
               "Time",
               selection: $date,
               displayedComponents: [.hourAndMinute]
           )
        Button(action: MyModel.shared.turnOffShieldRestrictions) {
            Text("Turn off all restrictions")
        }
        ExampleView()
            .environmentObject(model)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MyModel())
    }
}
