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
        VStack {
            Text("Select apps you want to manage on your devices:").font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
            Spacer().frame(height: 300.0)
            
            Button("Browse my App") {
                isDiscouragedPresented = true
                appSelected = true
            }
                    .buttonStyle(.borderedProminent)
                    .familyActivityPicker(isPresented: $isDiscouragedPresented, selection: $model.selectionToDiscourage)
                
        }.padding().navigationDestination(isPresented: $appSelected) {
            SetTimeLimitView()
        }
        
    }
}

#Preview {
    BrowseMyAppView(selectionToDiscourage: FamilyActivitySelection())
}
