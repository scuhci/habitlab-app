//
//  BrowseMyAppView.swift
//  HabitLab App
//
//  Created by Xinqi Zhang on 2/19/24.
//

import SwiftUI
import FamilyControls

struct BrowseMyAppView: View {
    @State private var isDiscouragedPresented = false
    @State var selectionToDiscourage: FamilyActivitySelection
    @State var appSelected: Bool = false
    @EnvironmentObject var model: MyModel
   
    var body: some View {
        VStack (spacing: 10) {
            Text("Set daily time limits for apps you want to manage on " + UIDevice.current.name + ".")
                .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            Button {
                isDiscouragedPresented = true
                appSelected = true
            } label: {
                HStack {
                    Text("Add limit")
                    Spacer()
                }
            }
            .buttonStyle(.bordered)
                    .buttonStyle(.borderedProminent)
                    .familyActivityPicker(isPresented: $isDiscouragedPresented, selection: $model.selectionToDiscourage)
            Spacer()
        }.padding().navigationDestination(isPresented: $appSelected) {
            SetTimeLimitView()
        }
        
    }
}

#Preview {
    BrowseMyAppView(selectionToDiscourage: FamilyActivitySelection())
}
