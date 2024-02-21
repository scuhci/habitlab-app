//
//  LandingView.swift
//  HabitLab App
//
//  Created by Xinqi Zhang on 2/19/24.
//

import SwiftUI
import FamilyControls

struct LandingView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to HabitLab :)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).fontWeight(.semibold)
                Spacer().frame(height: 300.0)
                NavigationLink(destination:BrowseMyAppView(selectionToDiscourage: FamilyActivitySelection())){
                    Text("Start🚀")
                }
            }.padding()
        } 
       
    }
}

#Preview {
    LandingView()
}
