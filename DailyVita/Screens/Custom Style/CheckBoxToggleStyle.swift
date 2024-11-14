//
//  CheckBoxToggleStyle.swift
//  DailyVita
//
//  Created by Kaung Khant Si Thu on 13/11/2024.
//


import SwiftUI

struct CheckBoxToggleStyle: ToggleStyle {
    let tip: String?
    
    init(tip: String? = nil) {
        self.tip = tip
    }
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 10) {
            
            Button(action: { configuration.isOn.toggle() }){
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "checkmark.square")
                    .foregroundStyle(configuration.isOn ? Color.accentColor : .secondary)
                    .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
            
            configuration.label
            
            if let tip, !tip.isEmpty {
//                Button {
//                    // do nothing
//                    print(tip)
//                } label: {
                    Image(systemName: "info.circle")
//                }
                .foregroundStyle(.blue)
            }
        }
    }
}
