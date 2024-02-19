//
//  LandingView.swift
//  HabitLab App
//
//  Created by Xinqi Zhang on 2/19/24.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        VStack {
            Text("Welcome to HabitLab :)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).fontWeight(.semibold)
            Spacer().frame(height: 300.0)
            Button("Start🚀") {}
                    .buttonStyle(.automatic)
            
            
        }.padding()
    }
}

#Preview {
    LandingView()
}
