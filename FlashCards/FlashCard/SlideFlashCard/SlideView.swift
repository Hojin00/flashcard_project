//
//  SlideView.swift
//  FlashCards
//
//  Created by Willian Magnum Albeche on 20/10/21.
//

import SwiftUI
import AVFoundation
import CloudKit



struct SlideView: View {
    
    @EnvironmentObject private var cloudkitManager: CloudKitManager
    /// List of users EXEMPLO TROCAR DEPOIS POR FLASH CARD
    var deck: Deck
    init(deck: Deck){
        self.deck = deck
        CloudKitManager.shared.fetchDeck(deckID: deck.myrecord.recordID) { Result in
            switch Result {
            case .success:
                print("Uhul")
                break
            default:
                print("failed")
                break
            }
        }
    }
    
    /// Return the CardViews width for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardWidth(_ geometry: GeometryProxy, id: String) -> CGFloat {
        guard let index = cloudkitManager.allFlashCards.firstIndex(where: {$0.id.recordName == id}) else {return 0}
        let offset: CGFloat = CGFloat((deck.flashcards ?? []).count - 1 - index)
        return geometry.size.width - offset
    }
    //    private func getCardHeight(_ geometry: GeometryProxy, id: Int) -> CGFloat {
    //        let offset: CGFloat = CGFloat(deck.flashcards.count - 1 - id)
    //        return geometry.size.height - offset
    //    }
    
    /// Return the CardViews frame offset for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardOffset(_ geometry: GeometryProxy, id: String) -> CGFloat {
        guard let index = cloudkitManager.allFlashCards.firstIndex(where: {$0.id.recordName == id}) else {return 0}
        return  CGFloat((deck.flashcards ?? []).count - 5 - index) * -10
    }
    
 
    
    
    
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                LinearGradient(gradient: Gradient(colors: [Color.init(#colorLiteral(red: 0.1764705926, green: 1, blue: 0.5607843399, alpha: 1)), Color.init(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]), startPoint: .bottom, endPoint: .top)
                    .frame(width: geometry.size.width * 1.5, height: geometry.size.height)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .offset(x: -geometry.size.width / 4, y: -geometry.size.height / 2)
                
                
                VStack(alignment: .center, spacing: 0.0) {
                    //DateView()
                    ZStack {
                        ForEach.init(cloudkitManager.allFlashCards) { card in
                            CardViewSlide(card: card) { _ in
                                
                            }
                            .animation(.spring())
                            .frame(width: self.getCardWidth(geometry, id: card.id.recordName), height: 500)
                            .offset(x: 0, y: self.getCardOffset(geometry, id: card.id.recordName))
                        }
                    
                        //self.cards.removeAll { $0.id == removedUser.id }
                 
                    }
                    Spacer()
                }
            }
        }
        .padding()
        .onAppear() {
            CloudKitManager.shared.fetchDeck(deckID: deck.myrecord.recordID) { Result in
                switch Result {
                case .success:
                    print("Uhul")
                    break
                default:
                    print("failed")
                    break
                }
            }
        }
    }
}


struct SlideView_Previews: PreviewProvider {
    static var previews: some View {
        SlideView(deck: Deck.init(record: CKRecord.init(recordType: "Deck")))
    }
}
