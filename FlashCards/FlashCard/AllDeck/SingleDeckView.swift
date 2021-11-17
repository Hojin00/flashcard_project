//
//  DeckView.swift
//  FlashCards
//
//  Created by João Brentano on 22/10/21.
//

import SwiftUI
import CloudKit

struct SingleDeckView: View {
    
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
        ZStack {
            NavigationLink(destination: EditDeckView(deck: deck, isNewDeck: false)) {
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
                        HStack {
                            Text("!!!")
                                .bold()
                                .padding(.leading, UIScreen.main.bounds.size.width * 0.08)
                            Spacer()
                            Image(systemName: "alarm")
                                .padding(.trailing, UIScreen.main.bounds.size.width * 0.08)
                        }
                        Spacer()
                            .font(.title)
                        Text("\(deck.title ?? "No title")")
                        Spacer()
                        Text("Remembered")
                            .font(.caption)
                        Text("77% easily")
                            .font(.caption)
                            .padding(.bottom)
                        Spacer()
                        HStack {
                            Spacer()
                            if let flashcardsNum = deck.flashcards {
                                Text("\(flashcardsNum.count)\ncards")
                                    .font(.caption)
                                    .padding(.trailing, UIScreen.main.bounds.size.width * 0.07)
                            }
                        }
                        Spacer()
                    }
                    .padding(.bottom, UIScreen.main.bounds.height * 0.030)
                    .foregroundColor(Color.black)
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.40, height: UIScreen.main.bounds.height * 0.25)
            VStack {
                Spacer()
                HStack {
                    Button {
                        print("...")
                    } label: {
                        StandardButton()
                    }
                    Spacer()
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.23, height: UIScreen.main.bounds.height * 0.15)
        }
    }
}

struct SingleDeckView_Previews: PreviewProvider {
    static var previews: some View {
        SingleDeckView(deck: Deck.init(record: CKRecord.init(recordType: "Deck")))
    }
}
