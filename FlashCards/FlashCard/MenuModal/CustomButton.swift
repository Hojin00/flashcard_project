//
//  CustomButton.swift
//  FlashCards
//
//  Created by Lucca Molon on 17/11/21.
//

import SwiftUI

struct customButton: View {
    
    var text: String
    var assetName: String
    var corners: UIRectCorner?
    
    var body: some View {
        ZStack {
            if corners != nil {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width * 0.86, height: UIScreen.main.bounds.height * 0.054)
                    .clipShape(CustomCorner(corners: corners!, radius: 15))
                    .foregroundColor(.gray)
                    .opacity(0.15)
                    .overlay (
                        HStack {
                            Text(text)
                                .padding(.leading, UIScreen.main.bounds.width * 0.03)
                            Spacer()
                            Image(systemName: assetName)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width * 0.045, height: UIScreen.main.bounds.width * 0.048)
                                .padding(.trailing, UIScreen.main.bounds.width * 0.03)
                        }
                    )
            } else {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width * 0.86, height: UIScreen.main.bounds.height * 0.058)
                    .foregroundColor(.gray)
                    .opacity(0.1)
                    .overlay (
                        HStack {
                            Text(text)
                                .padding(.leading, UIScreen.main.bounds.width * 0.03)
                            Spacer()
                            Image(systemName: assetName)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width * 0.045, height: UIScreen.main.bounds.width * 0.048)
                                .padding(.trailing, UIScreen.main.bounds.width * 0.03)
                        }
                    )
            }
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        customButton(text: "aaa", assetName: "trash", corners: [.topLeft])
    }
}
