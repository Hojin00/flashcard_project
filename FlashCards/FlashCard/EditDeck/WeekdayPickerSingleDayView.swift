//
//  WeekdayPickerSingleDayView.swift
//  FlashCards
//
//  Created by João Brentano on 03/11/21.
//

import SwiftUI

struct WeekdayPickerSingleDayView: View {
    
    @State var isSelected: Bool
    @Binding var selectedDays: [Bool]
    let title: String
    let dayNum: Int
    
    var body: some View {
        Button {
            selectedDays[dayNum].toggle()
            isSelected.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.gray)
                Text("\(title)")
                    .font(.caption)
                    .foregroundColor(.black)
            }
            .frame(width: UIScreen.main.bounds.width * 0.08, height: UIScreen.main.bounds.height * 0.03)
        }

    }
}

struct WeekdayPickerSingleDayView_Previews: PreviewProvider {
    
    @State static var selectedDays: [Bool] = [false, false, false, false, false, false, false]
    
    static var previews: some View {
        WeekdayPickerSingleDayView(isSelected: false, selectedDays: $selectedDays, title: "Mon", dayNum: 0)
    }
}
