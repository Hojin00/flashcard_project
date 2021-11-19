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
                .opacity(0.3)
            VStack {
                HStack {
                    Text("New Card")
                        .font(.title).bold()
                        .padding(.leading, screenSize.width * 0.05)
                    Spacer()
                }
                CardView {
                    NewCardSideView(side: .front)
                        .onDisappear {
                            isFlipped.toggle()
                        }
                } back: {
                    NewCardSideView(side: .back)
                        .onDisappear {
                            isFlipped.toggle()
                        }
                }
                if isFlipped {
                    Text("This is the front side, where you can put your question or tip. Then you can flip the card and fill the answer side.")
                        .font(.caption)
                        .padding(.top, screenSize.width * 0.03)
                        .padding(.horizontal, screenSize.width * 0.03)
                        .foregroundColor(.gray)
                } else {
                    Text("This is the back side, where you put the answer or explanation. Then you can flip the card and see the question or tip.")
                        .font(.caption)
                        .padding(.top, screenSize.width * 0.03)
                        .padding(.horizontal, screenSize.width * 0.03)
                        .foregroundColor(.gray)
                }
                NavigationLink(destination: EditDeckView(deck: nil, isNewDeck: true).navigationBarBackButtonHidden(true).offset(x: 0, y: -50)) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .foregroundColor(Color.gray)
                            .frame(width: screenSize.width * 0.4, height: screenSize.height * 0.055)
                        Text("Done")
                            .foregroundColor(.white)
                            .font(.title)
                    }
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
