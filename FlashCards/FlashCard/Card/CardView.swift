//
//  CardView.swift
//  FlashCards
//
//  Created by Lucca Molon on 19/10/21.
//

import SwiftUI

struct CardView<Front, Back>: View where Front: View, Back: View {
    
    let screenSize: CGSize = UIScreen.main.bounds.size
    
    var front: () -> Front 
    var back: () -> Back
    
    @State var flipped: Bool = false
    
    @State var flashcardRotation = 0.0
    @State var contentRotation = 0.0
    
    init(@ViewBuilder front: @escaping () -> Front, @ViewBuilder back: @escaping () -> Back) {
        self.front = front
        self.back = back
    }
    
    var body: some View {
        VStack {
            ZStack {
                if flipped {
                    back()
                } else {
                    front()
                }
            }
            .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
            //.padding()
            .frame(height: screenSize.height * 0.65)
            .frame(maxWidth: screenSize.width * 0.95)
            .background(flipped ? Color(red: 1, green: 1, blue: 1) : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 0.3)
                    .shadow(radius: 5)
            )
            .padding()
            .rotation3DEffect(.degrees(flashcardRotation), axis: (x: 0, y: 1, z: 0))
            Text("Tap to flip \(Image(systemName: "arrow.uturn.up"))")
                .onTapGesture {
                    flipFlashcard()
                }
        }
    }
    
    public func flipFlashcard() {
        let animationTime = 0.5
        withAnimation(Animation.linear(duration: animationTime)) {
            flashcardRotation += 180
        }
        
        withAnimation(Animation.linear(duration: 0.001).delay(animationTime / 2)) {
            contentRotation += 180
            flipped.toggle()
        }
    }
}




struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView {
            Text("Front")
        } back: {
            Text("Back")
        }
        
    }
}
