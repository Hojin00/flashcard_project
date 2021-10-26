//
//  DeckView.swift
//  FlashCards
//
//  Created by João Brentano on 22/10/21.
//

import SwiftUI

struct DeckView: View, Identifiable {
    var id: ObjectIdentifier
    
    var color1: Color
    var color2: Color
    var color3: Color
    
//    var deck: Deck
//    var flashcard1: FlashCard
//    var flashcard2: FlashCard
//    var flashcard3: FlashCard
    
//    func getFlashcards() -> [FlashCard] {
//        CloudKitManager.shared.fetchDeck(deckID: deck.myrecord.recordID) { result, error in
////            switch Result {
////            case .success(let flashcards):
////                let aux = flashcards as [FlashCard]
////                return [FlashCard]()
////                break
////            default:
////                print("no flashcards in deck")
////                break
////            }
//        }
//    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var body: some View {
        Button {
            //action
        } label: {
            ZStack {
                //Image("AllDecksDeckBackground")
                //    .padding(.top, UIScreen.main.bounds.height * 0.1)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(color3)
                    .frame(width: UIScreen.main.bounds.width * 0.270, height: UIScreen.main.bounds.height * 0.2)
                    .shadow(radius: 10)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(color2)
                    .frame(width: UIScreen.main.bounds.width * 0.285, height: UIScreen.main.bounds.height * 0.2)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.015)
                    .shadow(radius: 10)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(color1)
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
//
//struct DeckView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeckView(color1: Color.red, color2: Color.green, color3: Color.orange)
//    }
//}
