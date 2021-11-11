//
//  ThemePickerView.swift
//  FlashCards
//
//  Created by João Brentano on 10/11/21.
//

import SwiftUI

struct ThemePickerView: View {
    
    @Binding var selectedTheme: Int
    
    var body: some View {
        HStack {
            ThemePickerSingleThemeView(selectedTheme: $selectedTheme, themeColor: .red, themeNum: 1)
            ThemePickerSingleThemeView(selectedTheme: $selectedTheme, themeColor: .green, themeNum: 2)
            ThemePickerSingleThemeView(selectedTheme: $selectedTheme, themeColor: .blue, themeNum: 3)
        }
    }
}

struct ThemePickerView_Previews: PreviewProvider {
    
    @State static var selectedTheme: Int = 0
    
    static var previews: some View {
        ThemePickerView(selectedTheme: $selectedTheme)
    }
}
