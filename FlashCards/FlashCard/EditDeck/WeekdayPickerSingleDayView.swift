//
//  WeekdayPickerSingleDayView.swift
//  FlashCards
//
//  Created by João Brentano on 03/11/21.
//

import SwiftUI

struct WeekdayPickerSingleDayView: View {
    
    @State var textColor: Color = .black
    @Binding var selectedDays: [Bool]
    let title: String
    let dayNum: Int
    
    var body: some View {
        Button {
            selectedDays[dayNum].toggle()
            if selectedDays[dayNum] {
                textColor = .blue
            } else {
                textColor = .black
            }
        } label: {
            ZStack {
                if selectedDays[dayNum] {
                    //selecionado
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.blue)
                        .frame(width: UIScreen.main.bounds.width * 0.085, height: UIScreen.main.bounds.height * 0.0333)
                }
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color("lightGray"))
                    .frame(width: UIScreen.main.bounds.width * 0.08, height: UIScreen.main.bounds.height * 0.03)
                Text("\(title)")
                    .font(.caption)
                    .foregroundColor(textColor)
            }
            .frame(width: UIScreen.main.bounds.width * 0.08, height: UIScreen.main.bounds.height * 0.03)
        }

    }
}

struct WeekdayPickerSingleDayView_Previews: PreviewProvider {
    
    @State static var selectedDays: [Bool] = [false, false, false, false, false, false, false]
    
    static var previews: some View {
        WeekdayPickerSingleDayView(selectedDays: $selectedDays, title: "Mon", dayNum: 0)
    }
}
