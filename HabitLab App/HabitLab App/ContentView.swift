//
//  ContentView.swift
//  HabitLab App
//
//  Created by Husain Unwalla on 6/6/23.
//

import SwiftUI
import FamilyControls

struct ContentView: View {
    @State private var isDiscouragedPresented = false
    @State private var isEncouragedPresented = false
    
    @EnvironmentObject var model: MyModel
    
    var body: some View {
        let center = AuthorizationCenter.shared
        VStack {
            Button("Select Apps to Discourage") {
                isDiscouragedPresented = true
            }
            .familyActivityPicker(isPresented: $isDiscouragedPresented, selection: $model.selectionToDiscourage)
        }
        .onChange(of: model.selectionToDiscourage) { newSelection in
            MyModel.shared.setShieldRestrictions()
        }.onAppear{
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
