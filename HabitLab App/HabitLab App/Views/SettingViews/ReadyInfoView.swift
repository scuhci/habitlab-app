//
//  ReadyInfoView.swift
//  HabitLab App
//
//  Created by Xinqi Zhang on 2/19/24.
//

import SwiftUI

struct ReadyInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Fantastic🎉!").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).fontWeight(.semibold).lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
            Text("We're here to help you manage your app usage effectively. Your app will be automatically disabled once you reach your daily limit, ensuring you maintain a healthy digital balance. ")
                .font(.body).fontWeight(.medium).lineSpacing(15.0)
            Spacer().frame(height: 20.0)
            Text("Everything resets at midnight, allowing you to start fresh each day.")
                .font(.body).fontWeight(.medium).lineSpacing(15.0)
            Spacer().frame(height: 20.0)
            Text("Enjoy your day and make the most of your time!")
                .font(.body).fontWeight(.medium).lineSpacing(15.0)
            Spacer().frame(height: 20.0)
            HStack() {
                Spacer()
                Button("Got it!") {}
                    .buttonStyle(.borderedProminent)
            }
        }.padding()

       
        
    }
}

#Preview {
    ReadyInfoView()
}
