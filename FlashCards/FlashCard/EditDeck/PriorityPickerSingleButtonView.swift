//
//  PriorityButtonView.swift
//  FlashCards
//
//  Created by João Brentano on 03/11/21.
//

import SwiftUI

struct PrioritySingleButtonView: View {
    
    @Binding var selectedPriority: Int
    let buttonPriority: Int
    let symbol: String
    let text: String
    
    var body: some View {
        Button(action: {
            selectedPriority = buttonPriority
        }, label: {
            ZStack {
                if selectedPriority == buttonPriority {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.blue)
                        .frame(width: UIScreen.main.bounds.width * 0.1475, height: UIScreen.main.bounds.width * 0.1475)
                }
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color("lightGray"))
                    .frame(width: UIScreen.main.bounds.width * 0.14, height: UIScreen.main.bounds.width * 0.14)
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
    
    @State static var selectedPriority: Int = 0
    
    static var previews: some View {
        PrioritySingleButtonView(selectedPriority: $selectedPriority, buttonPriority: 0, symbol: "-", text: "None")
    }
}
