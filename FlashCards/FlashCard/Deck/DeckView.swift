//
//  DeckView.swift
//  FlashCards
//
//  Created by Lucca Molon on 22/10/21.
//

import SwiftUI
import CloudKit

struct DeckView: View {
    
    @Binding var deck: Deck
    
    var body: some View {
        
        var auxFlash: FlashCard? = nil
        
        
        ScrollView {
                VStack {
                    
                    Button("aaaaaaa") {
    //                    print("aaaaaa")
    //                    CloudKitManager.shared.fetchDeckFlashcards(flashcardID: (deck.flashcards?[0].recordID)!) { Result in
    //                        switch Result {
    //                        case .success(let flashcard):
    //                            print(flashcard)
    //                        default:
    //                            print("no flashcards")
    //                        }
    //                    }
                    }
                    VStack {
                        CardPreview(cardType: .newCard)
                        CardPreview(cardType: .practiceCard)
                        
                        CardPreview(cardType: .informationCard)
                        CardPreview(cardType: .normalCard)
                    }
                }
            
        }
    }
}

struct CardPreview: View {
    let screenSize: CGSize = UIScreen.main.bounds.size
    var cardType: CardType
    var flashcard: FlashCard?
    var body: some View {
        
            ZStack {
                
                if cardType == .newCard {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .frame(width: screenSize.width * 0.35, height: screenSize.height * 0.12)
                        .padding(.all, 2)
                    VStack {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: screenSize.width * 0.085, height: screenSize.height * 0.03, alignment: .center)
                        Text("New Card")
                            .padding(.top, screenSize.height * 0.01)
                    }
                    .frame(width: screenSize.width * 0.35, height: screenSize.height * 0.12)
                } else if cardType == .practiceCard {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .frame(width: screenSize.width * 0.35, height: screenSize.height * 0.12)
                        .padding(.all, 2)
                    VStack {
                        Image(systemName: "square.stack")
                            .resizable()
                            .frame(width: screenSize.width * 0.055, height: screenSize.height * 0.032)
                        Text("Practice Deck")
                            .padding(.top, 6)
                    }
                    .frame(width: screenSize.width * 0.35, height: screenSize.height * 0.12)
                } else if cardType == .informationCard {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .frame(width: screenSize.width * 0.35, height: screenSize.height * 0.22)
                        .padding(.all, 2)
                    VStack {
                        Text("High Importance")
                            .font(.custom("SFProDisplay-Light", size: 13))
                        Text("Deck Title Here")
                            .font(.custom("SFProDisplay-Bold", size: 13)).bold()
                        Text("Remembered 14% easily")
                            .font(.custom("SFProDisplay-Medium", size: 13))
                        HStack {
                            Button("aa") {
                                print("aa")
                            }
                            Text("140 cards")
                                .font(.custom("SFProDisplay-Light", size: 13))
                        }
                            
                    }
                    .frame(width: screenSize.width * 0.35, height: screenSize.height * 0.22)
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .frame(width: screenSize.width * 0.35, height: screenSize.height * 0.22)
                        .padding(.all, 2)
                    VStack {
                        
                    }
                }
            }
                
         
            
    }
}

enum CardType {
    case newCard, practiceCard, normalCard, informationCard
}


struct DeckView_Previews: PreviewProvider {
    @State static private var flashcardMock = FlashCard.init(myrecord: CKRecord.init(recordType: "FlashCard"), frontSideText: "front text", frontSideImage: nil, backSideText: "back text", backSideImage: nil, category: nil, frontSideAudio: nil, backSideAudio: nil)
    
    @State static private var deckmock = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: [CKRecord.Reference.init(record: flashcardMock.myrecord, action: .none)], title: "deck title", category: "lk", reminderDate: Date())

    
        
    static var previews: some View {
        DeckView(deck: $deckmock)
    }
}
