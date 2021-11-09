//
//  EditCardView.swift
//  FlashCards
//
//  Created by Lucca Molon on 05/11/21.
//

import SwiftUI

struct EditCardView: View {
    
    let screenSize: CGSize = UIScreen.main.bounds.size
    
    var flashcard: FlashCard? = nil
    
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
                    EditCardSideView(side: .front, flashcard: flashcard)
                        .onDisappear {
                            isFlipped.toggle()
                        }
                } back: {
                    EditCardSideView(side: .back, flashcard: flashcard)
                        .onDisappear {
                            isFlipped.toggle()
                        }
                }
                Button {
                    print("click")
                } label: {
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

struct EditCardView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardView()
    }
}
