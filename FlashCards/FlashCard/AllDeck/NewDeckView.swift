//
//  SingleDeckView.swift
//  FlashCards
//
//  Created by João Brentano on 20/10/21.
//

import SwiftUI

struct NewDeckView: View {
    
    var body: some View {
        Button {
            //action
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width * 0.270, height: UIScreen.main.bounds.height * 0.2)
                    .shadow(radius: 10)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width * 0.285, height: UIScreen.main.bounds.height * 0.2)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.015)
                    .shadow(radius: 10)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.2)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.030)
                    .shadow(radius: 10)
                VStack {
                    Text("+")
                        .font(.title)
                    Text("New Deck")
                }
                .padding(.bottom, UIScreen.main.bounds.height * 0.030)
                .foregroundColor(Color.black)
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.height * 0.25)
    }
}

struct NewDeckView_Previews: PreviewProvider {
    static var previews: some View {
        NewDeckView()
    }
}
