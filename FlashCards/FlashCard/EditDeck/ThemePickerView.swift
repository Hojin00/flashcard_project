//
//  ThemePickerView.swift
//  FlashCards
//
//  Created by João Brentano on 10/11/21.
//

import SwiftUI

struct ThemePickerView: View {
    
    @State var selectedTheme: Int = 0
    @State var selectedThemes: [Bool] = [true, false, false, false, false, false, false]
    
    var body: some View {
        HStack {
            Spacer()
            ThemePickerSingleThemeView(isSelected: selectedThemes[1], selectedTheme: $selectedTheme, selectedThemes: $selectedThemes, themeColor: .red, themeNum: 1)
            ThemePickerSingleThemeView(isSelected: selectedThemes[2], selectedTheme: $selectedTheme, selectedThemes: $selectedThemes, themeColor: .green, themeNum: 2)
            ThemePickerSingleThemeView(isSelected: selectedThemes[3], selectedTheme: $selectedTheme, selectedThemes: $selectedThemes, themeColor: .blue, themeNum: 3)
            Spacer()
        }
    }
}

struct ThemePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ThemePickerView()
    }
}
