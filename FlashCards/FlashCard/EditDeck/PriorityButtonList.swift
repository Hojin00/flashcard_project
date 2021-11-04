//
//  PriorityButtonList.swift
//  FlashCards
//
//  Created by João Brentano on 03/11/21.
//

import SwiftUI

struct PriorityButtonList: View {
    
    @State var selectedPriority: [Bool] = [true, false, false, false]
    
    var body: some View {
        HStack {
            PriorityButtonView(selected: selectedPriority[0], selectedPriority: $selectedPriority, buttonPriority: 0, symbol: "-", text: "None")
            PriorityButtonView(selected: selectedPriority[0], selectedPriority: $selectedPriority, buttonPriority: 0, symbol: "!", text: "Low")
            PriorityButtonView(selected: selectedPriority[0], selectedPriority: $selectedPriority, buttonPriority: 0, symbol: "!!", text: "Medium")
            PriorityButtonView(selected: selectedPriority[0], selectedPriority: $selectedPriority, buttonPriority: 0, symbol: "!!!", text: "High")
        }
    }
}

struct PriorityButtonList_Previews: PreviewProvider {
    static var previews: some View {
        PriorityButtonList()
    }
}
