//
//  PriorityButtonList.swift
//  FlashCards
//
//  Created by João Brentano on 03/11/21.
//

import SwiftUI

struct PriorityButtonList: View {

    @State var selectedPriority: Int = 0
    
    var body: some View {
        HStack {
            PriorityButtonView(selectedPriority: $selectedPriority, buttonPriority: 0, symbol: "-", text: "None")
            PriorityButtonView(selectedPriority: $selectedPriority, buttonPriority: 1, symbol: "!", text: "Low")
            PriorityButtonView(selectedPriority: $selectedPriority, buttonPriority: 2, symbol: "!!", text: "Medium")
            PriorityButtonView(selectedPriority: $selectedPriority, buttonPriority: 3, symbol: "!!!", text: "High")
        }
    }
}

struct PriorityButtonList_Previews: PreviewProvider {
    static var previews: some View {
        PriorityButtonList()
    }
}
