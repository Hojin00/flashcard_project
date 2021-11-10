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
    let themeColor: Color = .green
    let themeNum: Int
    
    var body: some View {
        Button {
            if isSelected {
                isSelected = false
                selectedTheme = 0
            } else {
                isSelected = true
                selectedTheme = themeNum
            }
        } label: {
            ZStack {
                if isSelected {
                    Circle()
                        .foregroundColor(.black)
                        .frame(width: UIScreen.main.bounds.width * 0.085, height: UIScreen.main.bounds.height * 0.085)
                }
                Circle()
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width * 0.07, height: UIScreen.main.bounds.height * 0.07)
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
        ThemePickerSingleThemeView(isSelected: false, selectedTheme: $selectedTheme, themeNum: 1)
    }
}
