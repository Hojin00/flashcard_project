//
//  PriorityButtonList.swift
//  FlashCards
//
//  Created by João Brentano on 03/11/21.
//

import SwiftUI

struct PriorityButtonList: View {
    
    @State var priorities: [Bool] = [true, false, false, false]
    @Binding var selectedPriority: Int
    
    var body: some View {
        HStack {
            PriorityButtonView(selected: $selectedPriority, priorities: $priorities, buttonPriority: 0, symbol: "-", text: "None")
            PriorityButtonView(selected: $selectedPriority, priorities: $priorities, buttonPriority: 1, symbol: "!", text: "Low")
            PriorityButtonView(selected: $selectedPriority, priorities: $priorities, buttonPriority: 2, symbol: "!!", text: "Medium")
            PriorityButtonView(selected: $selectedPriority, priorities: $priorities, buttonPriority: 3, symbol: "!!!", text: "High")
        }
    }
}

struct PriorityButtonList_Previews: PreviewProvider {
    
    @State static var selectedPriority: Int = 0
    
    static var previews: some View {
        PriorityButtonList(selectedPriority: $selectedPriority)
    }
}
