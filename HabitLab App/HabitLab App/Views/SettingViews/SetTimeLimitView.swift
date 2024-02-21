//
//  SetTimeLimitView.swift
//  HabitLab App
//
//  Created by Xinqi Zhang on 2/19/24.
//

import SwiftUI

struct SetTimeLimitView: View {
    @State private var hours : Int = 0
    @State private var minutes: Int = 0
    @State private var timeSelected : Bool = false
    var body: some View {
        VStack {
            Text("Set daily time limit:").font(.headline)
            HStack{
                Picker("", selection: $hours){
                    ForEach(0..<24, id: \.self) { i in
                        Text("\(i)").tag(i)
                    }
                }.pickerStyle(WheelPickerStyle())
                Text("hours")
                Picker("", selection: $minutes){
                    ForEach(0..<60, id: \.self) { i in
                        Text("\(i)").tag(i)
                    }
                }.pickerStyle(WheelPickerStyle())
                Text("min")
            }.padding((.horizontal))
            Spacer().frame(height: 120.0)
            Button("Ready!") {
                timeSelected = true
            }
                .buttonStyle(.borderedProminent)
            
        }.padding().navigationDestination(isPresented: $timeSelected) {
            ReadyInfoView()
        }
    }
}

#Preview {
    SetTimeLimitView()
}
