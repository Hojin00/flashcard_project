//
//  ThemePickerSingleThemeView.swift
//  FlashCards
//
//  Created by João Brentano on 10/11/21.
//

import SwiftUI

struct ThemePickerSingleThemeView: View {
    
    @Binding var selectedTheme: Int
    let themeColor: Color
    let themeNum: Int
    
    var body: some View {
        Button {
            selectedTheme = themeNum
        } label: {
            ZStack {
                if selectedTheme == themeNum {
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
    
    static var previews: some View {
        ThemePickerSingleThemeView(selectedTheme: $selectedTheme, themeColor: .green, themeNum: 1)
    }
}
