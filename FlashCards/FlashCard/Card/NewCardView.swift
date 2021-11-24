//
//  NewCardView.swift
//  FlashCards
//
//  Created by Lucca Molon on 03/11/21.
//

import SwiftUI
import CloudKit

struct NewCardView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var deck:Deck?
    
    let screenSize: CGSize = UIScreen.main.bounds.size
    @State var newFlashCard: FlashCard?
    
    @State var isFlipped = false
    @State var auxNewFCReference: CKRecord.Reference?
    @State var frontSideTitle: String = ""
    @State var frontSideText: String = ""
    @State var frontSideAudio: CKAsset?
    @State var backSideTitle: String = ""
    @State var backSideText: String = ""
    @State var backSideAudio: CKAsset?

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
                    NewCardSideView(side: .front, frontSideTitle: $frontSideTitle, frontSideText: $frontSideText, frontSideAudio: $frontSideAudio, backSideTitle: $backSideTitle, backSideText: $backSideText, backSideAudio: $backSideAudio)
                        .onDisappear {
                            isFlipped.toggle()
                        }
                } back: {
                    NewCardSideView(side: .back, frontSideTitle: $frontSideTitle, frontSideText: $frontSideText, frontSideAudio: $frontSideAudio, backSideTitle: $backSideTitle, backSideText: $backSideText, backSideAudio: $backSideAudio)
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
                Button {
                    guard var newFlashCard = newFlashCard else {
                        return
                    }

                    newFlashCard.frontSideTitle = frontSideTitle
                    newFlashCard.frontSideText = frontSideText
                    newFlashCard.frontSideAudio = frontSideAudio
                    newFlashCard.backSideTitle = backSideTitle
                    newFlashCard.backSideText = backSideText
                    newFlashCard.backSideAudio = backSideAudio
                    
                    
                    CloudKitManager.shared.updateFlashCard(flashCard: newFlashCard)
                    
                    guard var deck = deck else {
                        print("deck")
                        return
                    }
                    
                    auxNewFCReference = CKRecord.Reference.init(recordID: newFlashCard.id, action: .none)
                    
                    guard let auxNewFCReference = auxNewFCReference else {
                        print("auxnewRefere")
                        return
                    }


                    
                    
                    deck.flashcards?.append(auxNewFCReference)
                    
                    CloudKitManager.shared.updateDeck(deck: deck)
                    
                    print("click")
                    self.presentationMode.wrappedValue.dismiss()
                    
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
        }.onAppear {
            newFlashCard = FlashCard.createEmptyFlashCard()
            
        }
    }
}
//
//struct NewCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewCardView(deck: Deck.init(record: CKRecord.init(recordType: "Deck")), newFlashCard: FlashCard.init(record: CKRecord.init(recordType: "FlashCard")))
//    }
//}
