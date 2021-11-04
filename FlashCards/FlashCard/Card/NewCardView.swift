//
//  NewCardView.swift
//  FlashCards
//
//  Created by Lucca Molon on 03/11/21.
//

import SwiftUI

struct NewCardView: View {
    
    let screenSize: CGSize = UIScreen.main.bounds.size
    
    @State var isFlipped = false

    var body: some View {
        ZStack {
            Circle()
                .frame(width: screenSize.width * 1.4, height: screenSize.width * 1.4)
                .padding(.top, screenSize.width * -1.3)
                .foregroundColor(.gray)
                .opacity(0.5)
            VStack {
                HStack {
                    Text("New Card")
                        .font(.title).bold()
                        .padding(.leading, screenSize.width * 0.05)
                    Spacer()
                }
                CardView {
                    NewCardSideView(side: .front)
                } back: {
                    NewCardSideView(side: .back)
                }
                if isFlipped {
                    Text("aaa")
                } else {
                    Text("bbb")
                }
            }
            .frame(width: screenSize.width, height: screenSize.height)
        }
    }
}

struct NewCardView_Previews: PreviewProvider {
    static var previews: some View {
        NewCardView()
    }
}
