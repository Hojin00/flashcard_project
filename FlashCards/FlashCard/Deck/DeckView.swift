//
//  DeckView.swift
//  FlashCards
//
//  Created by Lucca Molon on 22/10/21.
//

import SwiftUI
import CloudKit

struct DeckView: View {
    
    var deck: Deck
    let screenSize: CGSize = UIScreen.main.bounds.size
    @State private var searchText: String = ""
    @State var flashcards: [FlashCard] = []
    
    init(deck: Deck) {
        self.deck = deck
        var auxFlashCard: [FlashCard] = []
        CloudKitManager.shared.fetchDeck(deckID: deck.myrecord.recordID) { Result in
            switch Result {
            case .success(let flashcard):
                auxFlashCard = flashcard
                print(flashcard)
            default:
                print("error")
            }
        }
        flashcards = auxFlashCard
    }

    var body: some View {
        
        //var auxFlash: FlashCard? = nil
        ZStack {
            Circle()
                .ignoresSafeArea()
                .frame(width: screenSize.width * 1.4, height: screenSize.width * 1.4)
                .padding(.top, screenSize.width * -1.3)
                .foregroundColor(.gray)
                .opacity(0.5)
            VStack() {
                Text("Deck Cards")
                    .font(.title).bold()
                SearchBar(text: $searchText)
                    .frame(width: screenSize.width * 0.95, height: screenSize.height * 0.05, alignment: .center)
                ScrollView {
                    VStack {
                        HStack(alignment: .center) {
                                VStack {
                                    CardPreview(cardType: .practiceCard)
                                    CardPreview(cardType: .newCard)
                                }
                            CardPreview(cardType: .informationCard, deck: deck)
                            }
                            ForEach(flashcards, id: \.self) { flashcard in
                                CardPreview(cardType: .normalCard, flashcard: flashcard)
                                }
                        }
                }
            }
            
            .padding()
        }
        
    }
}

struct CardPreview: View {
    let screenSize: CGSize = UIScreen.main.bounds.size
    var cardType: CardType
    var flashcard: FlashCard?
    var deck: Deck?
    var body: some View {
            ZStack {
               if cardType == .newCard {
                    Button() {
                        print("click")
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                                .frame(width: screenSize.width * 0.35, height: screenSize.height * 0.12)
                            .padding(.all, 2)
                            VStack {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: screenSize.width * 0.06, height: screenSize.width * 0.05, alignment: .center)
                                    .foregroundColor(.black)
                                Text("New Card")
                                    .padding(.top, screenSize.height * 0.01)
                                    .foregroundColor(.black)
                            }
                            .frame(width: screenSize.width * 0.35, height: screenSize.height * 0.12)
                            .padding(.all, screenSize.width * 0.01)
                        }
                        
                    }
                } else if cardType == .practiceCard {
                    Button() {
                        print("clock")
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                                .frame(width: screenSize.width * 0.35, height: screenSize.height * 0.12)
                                .padding(.all, 2)
                            VStack {
                                Image(systemName: "square.stack")
                                    .resizable()
                                    .frame(width: screenSize.width * 0.055, height: screenSize.height * 0.032)
                                    .foregroundColor(.black)
                                Text("Practice Deck")
                                    .padding(.top, 6)
                                    .foregroundColor(.black)
                            }
                            .frame(width: screenSize.width * 0.35, height: screenSize.height * 0.12)
                            .padding(.all, screenSize.width * 0.02)
                        }
                    }
                } else if cardType == .informationCard {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .frame(width: screenSize.width * 0.35, height: screenSize.height * 0.26)
                        .padding(.all, 2)
                    VStack {
                        VStack {
                            Spacer()
                            Text("High importance")
                                .font(.caption)
                            Text("\(deck?.title ?? "Deck title here if to big ooooooooo")")
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(2)
                                .padding(.vertical, screenSize.width * 0.01)
                                .padding(.horizontal, screenSize.width * 0.015)
                            Text("Remembered")
                                .font(.caption)
                            Text("77% easily")
                                .font(.caption)
                            Spacer()
                                .onTapGesture {
                                    print("hellou")
                            }
                        }
                        .onTapGesture {
                            print("ha")
                        }
                        HStack {
                            Button() {
                                print("click")
                            } label: {
                                StandartButton()
                            }
                                .padding(.leading, screenSize.width * -0.06)
                            Text("120 cards")
                                .font(.caption)
                        }
                        .padding()
                    }
                    .frame(width: screenSize.width * 0.35, height: screenSize.height * 0.26)
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .frame(width: screenSize.width * 0.35, height: screenSize.height * 0.26)
                        .padding(.all, screenSize.width * 0.01)
                    VStack {
                        VStack {
                            Text("Card Title goes here if too big ohh")
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(2)
                                .padding(.top, screenSize.width * 0.02)
                                .padding(.bottom, screenSize.width * 0.04)
                                .padding(.horizontal, screenSize.width * 0.015)
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: screenSize.width * 0.2, height: screenSize.width * 0.2)
                                .foregroundColor(.gray)
                                .opacity(0.5)
                            
                        }
                        .onTapGesture {
                            print("he")
                        }
                        HStack {
                            Button() {
                                print("hohoho")
                            } label: {
                                StandartButton()
                                    .padding(.leading, screenSize.width * 0.03)
                                    .padding(.bottom, screenSize.width * -0.02)
                        }
                            Spacer()
                        }
                    }
                    .frame(width: screenSize.width * 0.35, height: screenSize.height * 0.26)
                    .padding(.all, screenSize.width * 0.01)
                }
            }
    }
}

enum CardType {
    case newCard, practiceCard, normalCard, informationCard
}

struct StandartButton: View {
    let screenSize: CGSize = UIScreen.main.bounds.size
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.gray)
                .shadow(radius: 3)
                .opacity(0.5)
            Image(systemName: "ellipsis")
                .foregroundColor(.black)
        }
        .frame(width: screenSize.width * 0.08, height: screenSize.width * 0.08)
    }
}


struct DeckView_Previews: PreviewProvider {
    @State static private var flashcardMock = FlashCard.init(myrecord: CKRecord.init(recordType: "FlashCard"), frontSideText: "front text", frontSideImage: nil, backSideText: "back text", backSideImage: nil, category: nil, frontSideAudio: nil, backSideAudio: nil)
    
    static private var deckmock = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: [CKRecord.Reference.init(record: flashcardMock.myrecord, action: .none)], title: "deck title hellou", category: "lk", reminderDate: Date())

    
        
    static var previews: some View {
        DeckView(deck: deckmock)
    }
}
