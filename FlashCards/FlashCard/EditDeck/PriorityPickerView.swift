//
//  PriorityPickerView.swift
//  FlashCards
//
//  Created by João Brentano on 03/11/21.
//

import SwiftUI

struct PriorityPickerView: View {

    @Binding var selectedPriority: Int
    
    var body: some View {
        HStack {
            PrioritySingleButtonView(selectedPriority: $selectedPriority, buttonPriority: 0, symbol: "-", text: "None")
            PrioritySingleButtonView(selectedPriority: $selectedPriority, buttonPriority: 1, symbol: "!", text: "Low")
            PrioritySingleButtonView(selectedPriority: $selectedPriority, buttonPriority: 2, symbol: "!!", text: "Medium")
            PrioritySingleButtonView(selectedPriority: $selectedPriority, buttonPriority: 3, symbol: "!!!", text: "High")
        }
    }
}

struct PriorityPickerView_Previews: PreviewProvider {
    
    @State static var selectedPriority: Int = 0
    
    static var previews: some View {
        PriorityPickerView(selectedPriority: $selectedPriority)
    }
}
