//
//  ScrollViewHorizontal.swift
//  CevaSearch
//
//  Created by Willian Magnum Albeche on 10/05/21.
//

import SwiftUI

struct HorizontalScrollView: View {
    
    @State var render: Bool = false
    @State var decks = [Deck]()
    
    private func getScale(proxy: GeometryProxy) -> CGFloat{
        let viewFrame = proxy.frame(in: CoordinateSpace.global)
        let midPoint: CGFloat = 175
        var scale: CGFloat = 1.0
        let deltaXAnimationThreshold: CGFloat = 125
        
        let diffFromCenter = abs(midPoint - viewFrame.origin.x - deltaXAnimationThreshold / 2)
        if diffFromCenter < deltaXAnimationThreshold {
            scale = 1 + (deltaXAnimationThreshold - diffFromCenter) / 500
        }
        return scale
    }
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 70) {
                        ForEach(decks) { deck in
                            ZStack {
                                GeometryReader { proxy in
                                    let scale = getScale(proxy: proxy)
                                    VStack(spacing: 8) {
                                        Text("AAA\(deck.flashcards[0].frontSideText ?? "nil")")
//                                        ZStack {
                                            //NavigationLink(destination: BeerView(beer: beer)) {
//                                            deck.title
//                                                .resizable()
//                                                .scaledToFill()
//                                                .frame(width: 225)
//                                                .clipped()
//                                                .cornerRadius(8)
//                                                .overlay(
//                                                    RoundedRectangle(cornerRadius: 8)
//                                                        .stroke(Color(white: 0.4))
//                                                )
//                                                .shadow(radius: 3)
                                            //}
//                                        }
                                        
                                    }
                                    .scaleEffect(.init(width: scale, height: scale))
                                    //                                    .animation(.spring(), value: 1)
                                    .animation(.easeOut(duration: 1))
                                    .padding(.vertical)
                                }
                                
                                .frame(width: 130, height: 300)
                                
                                
                            }
                        }
                        .padding(.horizontal, 32)
                        .padding(.vertical, 32)
                        Spacer()
                    }
                    .padding(32)
                }
                .frame( height: 400)
            }
        }
        //MARK: - TEMPORARY MOCKUP
        .onAppear() {
            if decks.isEmpty {
                var deck1: Deck = Deck(id: 0, flashcards: [], title: "Deck 1", category: "Cat1", reminderDate: nil)
                let flashcard1: FlashCard = FlashCard(frontSideText: "frontSideText", frontSideImage: nil, backSideText: "backSideText", backSideImage: nil, category: "category")
                deck1.flashcards.append(flashcard1)
                decks.append(deck1)
                decks.append(deck1)
                decks.append(deck1)
                decks.append(deck1)
                decks.append(deck1)
                decks.append(deck1)
            }
        }
    }
}

struct ScrollViewHorizontal_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalScrollView()
    }
}
