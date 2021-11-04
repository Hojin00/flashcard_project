//
//  WeekdayPickerView.swift
//  FlashCards
//
//  Created by João Brentano on 03/11/21.
//

import SwiftUI

struct WeekdayPickerView: View {
    
    @State var selectedDays: [Bool] = [false, false, false, false, false, false, false]
    
    var body: some View {
        HStack {
            Spacer()
            WeekdayPickerSingleDayView(isSelected: selectedDays[0], selectedDays: $selectedDays, title: "Mon", dayNum: 0)
            WeekdayPickerSingleDayView(isSelected: selectedDays[1], selectedDays: $selectedDays, title: "Tue", dayNum: 1)
            WeekdayPickerSingleDayView(isSelected: selectedDays[2], selectedDays: $selectedDays, title: "Wed", dayNum: 2)
            WeekdayPickerSingleDayView(isSelected: selectedDays[3], selectedDays: $selectedDays, title: "Thu", dayNum: 3)
            WeekdayPickerSingleDayView(isSelected: selectedDays[4], selectedDays: $selectedDays, title: "Fri", dayNum: 4)
            WeekdayPickerSingleDayView(isSelected: selectedDays[5], selectedDays: $selectedDays, title: "Sat", dayNum: 5)
            WeekdayPickerSingleDayView(isSelected: selectedDays[6], selectedDays: $selectedDays, title: "Sun", dayNum: 6)
            Spacer()
        }
    }
}

struct WeekdayPickerView_Previews: PreviewProvider {
    static var previews: some View {
        WeekdayPickerView()
    }
}
