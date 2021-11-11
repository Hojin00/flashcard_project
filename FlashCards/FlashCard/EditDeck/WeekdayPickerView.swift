//
//  WeekdayPickerView.swift
//  FlashCards
//
//  Created by João Brentano on 03/11/21.
//

import SwiftUI

struct WeekdayPickerView: View {
    
    @Binding var selectedDays: [Bool]
    
    var body: some View {
        HStack {
            Spacer()
            WeekdayPickerSingleDayView(selectedDays: $selectedDays, title: "Mon", dayNum: 0)
            WeekdayPickerSingleDayView(selectedDays: $selectedDays, title: "Tue", dayNum: 1)
            WeekdayPickerSingleDayView(selectedDays: $selectedDays, title: "Wed", dayNum: 2)
            WeekdayPickerSingleDayView(selectedDays: $selectedDays, title: "Thu", dayNum: 3)
            WeekdayPickerSingleDayView(selectedDays: $selectedDays, title: "Fri", dayNum: 4)
            WeekdayPickerSingleDayView(selectedDays: $selectedDays, title: "Sat", dayNum: 5)
            WeekdayPickerSingleDayView(selectedDays: $selectedDays, title: "Sun", dayNum: 6)
            Spacer()
        }
    }
}

struct WeekdayPickerView_Previews: PreviewProvider {
    
    @State static var selectedDays: [Bool] = [false, false, false, false, false, false, false]
    
    static var previews: some View {
        WeekdayPickerView(selectedDays: $selectedDays)
    }
}
