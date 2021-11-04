//
//  PriorityButtonView.swift
//  FlashCards
//
//  Created by João Brentano on 03/11/21.
//

import SwiftUI

struct PriorityButtonView: View {
    
    @Binding var selected: Int
    @Binding var priorities: [Bool]
    let buttonPriority: Int
    let symbol: String
    let text: String
    
    var body: some View {
        Button(action: {
            priorities = [false, false, false, false]
            priorities[buttonPriority] = true
            selected = buttonPriority
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.gray)
                VStack {
                    Text("\(symbol)")
                    Text("\(text)")
                }
                .font(.subheadline)
                .foregroundColor(.black)
            }
            .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.width * 0.15)
        })
    }
}

struct PriorityButtonView_Previews: PreviewProvider {
    
    @State static var priorities: [Bool] = [false, false, false, false]
    @State static var selectedPriority: Int = 0
    
    static var previews: some View {
        PriorityButtonView(selected: $selectedPriority, priorities: $priorities, buttonPriority: 0, symbol: "-", text: "None")
    }
}
