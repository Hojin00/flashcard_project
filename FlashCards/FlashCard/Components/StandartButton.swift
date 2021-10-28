//
//  StandartButton.swift
//  FlashCards
//
//  Created by Lucca Molon on 28/10/21.
//

import SwiftUI

struct StandartButton: View {
    let screenSize: CGSize = UIScreen.main.bounds.size
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.gray)
                .shadow(radius: 3)
                .opacity(0.5)
            Image(systemName: "ellipsis")
                .foregroundColor(.black)
        }
        .frame(width: screenSize.width * 0.08, height: screenSize.width * 0.08)
    }
}

struct StandartButton_Previews: PreviewProvider {
    static var previews: some View {
        StandartButton()
    }
}
