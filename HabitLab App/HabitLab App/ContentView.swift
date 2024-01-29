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
            VStack(alignment: .leading) {
                Text("Set daily llimits for app categories you want to manage on your devices\nLimits reset at midnight")
                    .font(.footnote)
                Button("Add limit") {
                    isDiscouragedPresented = true
                }
                .buttonStyle(.bordered)
                .familyActivityPicker(isPresented: $isDiscouragedPresented, selection: $model.selectionToDiscourage)
                Spacer()
                    .frame(height: 50)
                Text("Set daily time limit")
                HStack{
                    Picker("", selection: $model.hours){
                        ForEach(0..<24, id: \.self) { i in
                            Text("\(i)").tag(i)
                        }
                    }.pickerStyle(WheelPickerStyle())
                    Text("hours")
                    Picker("", selection: $model.minutes){
                        ForEach(0..<60, id: \.self) { i in
                            Text("\(i)").tag(i)
                        }
                    }.pickerStyle(WheelPickerStyle())
                    Text("min")
                }
                .padding(.horizontal)
                Spacer()
            }
            .padding(.horizontal)
            .onChange(of: model.selectionToDiscourage) { newSelection in
                //MySchedule.setSchedule()
                model.setShieldRestrictions()
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
