//
//  ThemePickerSingleThemeView.swift
//  FlashCards
//
//  Created by João Brentano on 10/11/21.
//

import SwiftUI

struct ThemePickerSingleThemeView: View {
    
    @State var isSelected: Bool
    @Binding var selectedTheme: Int
    @Binding var selectedThemes: [Bool]
    let themeColor: Color
    let themeNum: Int
    
    var body: some View {
        Button {
            DispatchQueue.main.async {
                if isSelected {
                    selectedTheme = 0
                    selectedThemes = [true, false, false, false, false, false, false]
                    isSelected = false
                } else {
                    selectedTheme = themeNum
                    selectedThemes = [false, false, false, false, false, false, false]
                    selectedThemes[themeNum] = true
                    isSelected = true
                }
            }
        } label: {
            ZStack {
                if isSelected {
                    Circle()
                        .foregroundColor(.black)
                        .frame(width: UIScreen.main.bounds.width * 0.09, height: UIScreen.main.bounds.height * 0.09)
                }
                Circle()
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width * 0.08, height: UIScreen.main.bounds.height * 0.08)
                Circle()
                    .foregroundColor(themeColor)
                    .frame(width: UIScreen.main.bounds.width * 0.06, height: UIScreen.main.bounds.height * 0.06)
            }
            .frame(width: UIScreen.main.bounds.width * 0.08, height: UIScreen.main.bounds.height * 0.03)
        }

    }
}

struct ThemePickerSingleThemeView_Previews: PreviewProvider {
    
    @State static var selectedTheme: Int = 0
    @State static var selectedThemes: [Bool] = [true, false, false, false, false, false, false]
    
    static var previews: some View {
        ThemePickerSingleThemeView(isSelected: false, selectedTheme: $selectedTheme, selectedThemes: $selectedThemes, themeColor: .green, themeNum: 1)
    }
}
