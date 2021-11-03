//
//  PriorityButtonView.swift
//  FlashCards
//
//  Created by João Brentano on 03/11/21.
//

import SwiftUI

struct PriorityButtonView: View {
    
    @State var selected: Bool
    @Binding var selectedPriority: [Bool]
    let buttonPriority: Int
    let symbol: String
    let text: String
    
    var body: some View {
        Button(action: {
            selectedPriority = [false, false, false, false]
            selectedPriority[buttonPriority] = true
            selected = true
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
    @State static var selectedPriority: [Bool] = [false, false, false, false]
    static var previews: some View {
        PriorityButtonView(selected: false, selectedPriority: $selectedPriority, buttonPriority: 0, symbol: "-", text: "None")
    }
}
