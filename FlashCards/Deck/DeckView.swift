//
//  DeckView.swift
//  FlashCards
//
//  Created by João Brentano on 22/10/21.
//

import SwiftUI
import CloudKit

struct DeckView: View {
    
    let deck: Deck
    var flashcards: [FlashCard] = []
    var topCardColor: Color = Color.white
    var middleCardColor: Color = Color.white
    var bottomCardColor: Color = Color.white
    
    init(deck: Deck) {
        self.deck = deck
        self.flashcards = getFlashcards()
        //        self.topCardColor = flashcards[0].frontSideColor as! Color
        //        self.middleCardColor = flashcards[1].frontSideColor as! Color
        //        self.bottomCardColor = flashcards[2].frontSideColor as! Color
    }
    
    func getFlashcards() -> [FlashCard] {
        var list: [FlashCard] = []
        CloudKitManager.shared.fetchDeck(deckID: deck.myrecord.recordID) { Result in
            switch Result {
            case .success(let rr):
                list = rr
                break
            default:
                print("no flashcards in deck")
                break
            }
        }
        return list
    }
    
    var body: some View {
        Button {
            //action
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(bottomCardColor)
                    .frame(width: UIScreen.main.bounds.width * 0.270, height: UIScreen.main.bounds.height * 0.2)
                    .shadow(radius: 10)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(middleCardColor)
                    .frame(width: UIScreen.main.bounds.width * 0.285, height: UIScreen.main.bounds.height * 0.2)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.015)
                    .shadow(radius: 10)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(topCardColor)
                    .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.2)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.030)
                    .shadow(radius: 10)
                VStack {
                    Spacer()
                    Text("High importance")
                        .font(.caption)
                    Spacer()
                        .font(.title)
                    Text("\(deck.title ?? "No title")")
                    Spacer()
                    Text("Remembered")
                        .font(.caption)
                    Text("77% easily")
                        .font(.caption)
                    Spacer()
                    HStack {
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(.gray)
                                .shadow(radius: 3)
                                .opacity(0.5)
                            Image(systemName: "ellipsis")
                                .foregroundColor(.black)
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.08, height: UIScreen.main.bounds.width * 0.08)
                        Text("120 cards")
                            .font(.caption)
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.bottom, UIScreen.main.bounds.height * 0.030)
                .foregroundColor(Color.black)
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.40, height: UIScreen.main.bounds.height * 0.25)
    }
}

struct DeckView_Previews: PreviewProvider {
    static var previews: some View {
        DeckView(deck: Deck.init(record: CKRecord.init(recordType: "Deck")))
    }
}
