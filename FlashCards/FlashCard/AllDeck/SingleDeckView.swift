//
//  DeckView.swift
//  FlashCards
//
//  Created by João Brentano on 22/10/21.
//

import SwiftUI
import CloudKit

struct SingleDeckView: View {
    @EnvironmentObject private var cloudkitManager: CloudKitManager
    let deck: Deck
    var flashcards: [FlashCard] = []
    @State var selectedTheme: Int = 0
    var themeColor: Color {
        switch selectedTheme {
        case 0:
            return Color("greenColor")
            
        case 1:
            return Color("blueColor")
            
        case 2:
            return Color("redColor")
            
        case 3:
            return Color("yellowColor")
            
        default:
            return Color("greenColor")
        }
    }
    var lightThemeColor: Color {
        switch selectedTheme {
        case 0:
            return Color("lightGreenColor")
            
        case 1:
            return Color("lightBlueColor")
            
        case 2:
            return Color("lightRedColor")
            
        case 3:
            return Color("lightYellowColor")
            
        default:
            return Color("lightGreenColor")
        }
    }
    
    init(deck: Deck) {
        self.deck = deck
        //self.flashcards = getFlashcards()
        //        self.topCardColor = flashcards[0].frontSideColor as! Color
        //        self.middleCardColor = flashcards[1].frontSideColor as! Color
        //        self.bottomCardColor = flashcards[2].frontSideColor as! Color
    }
    
//    func getFlashcards() -> [FlashCard] {
//        var list: [FlashCard] = []
//        CloudKitManager.shared.fetchDeck(deckID: deck.myrecord.recordID) { Result in
//            switch Result {
//            case .success(let rr):
//                list = rr
//                break
//            default:
//                print("no flashcards in deck")
//                break
//            }
//        }
//        return list
//    }
    
    var body: some View {
        ZStack {
            NavigationLink(destination: EditDeckView(deck: deck, isNewDeck: false)) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(lightThemeColor)
                        .frame(width: UIScreen.main.bounds.width * 0.270, height: UIScreen.main.bounds.height * 0.2)
                        .shadow(radius: 10)
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(lightThemeColor)
                        .frame(width: UIScreen.main.bounds.width * 0.285, height: UIScreen.main.bounds.height * 0.2)
                        .padding(.bottom, UIScreen.main.bounds.height * 0.015)
                        .shadow(radius: 10)
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.2)
                        .shadow(radius: 10)
                        .padding(.bottom, UIScreen.main.bounds.height * 0.030)
                    VStack {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.height * 0.015)
                            .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 50))
                            .foregroundColor(themeColor)
                            .padding(.top, UIScreen.main.bounds.height * 0.005)
                        Spacer()
                    }
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
                        .padding(.top)
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
