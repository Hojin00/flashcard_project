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
    let screenSize: CGSize = UIScreen.main.bounds.size
    
    // @EnvironmentObject private var cloudkitManager: CloudKitManager
    @State private var flashcards:[FlashCard] = []
    @State private var totalCards:Int = 0
    /// List of users EXEMPLO TROCAR DEPOIS POR FLASH CARD
    var deck: Deck
    init(deck: Deck){
        self.deck = deck
    }
    
    //    init(flashcards: [FlashCard]){
    //        self._flashcards = State.init(initialValue: flashcards)
    //    }
    
    /// Return the CardViews width for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardWidth(_ geometry: GeometryProxy, id: String) -> CGFloat {
        guard let index = flashcards.firstIndex(where: {$0.id.recordName == id}) else {return 0}
        let offset: CGFloat = CGFloat((flashcards).count - 1 - index)
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
        guard let index = flashcards.firstIndex(where: {$0.id.recordName == id}) else {return 0}
        print(id, index)
        return  CGFloat((flashcards).count - index) * -10
    }
    
    
    
    
    
    
    var body: some View {
        print(flashcards.count)
        return VStack(alignment: .trailing) {
            GeometryReader { geometry in
                
                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .bottom, endPoint: .top)
                    .frame(width: geometry.size.width * 1.5, height: geometry.size.height)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .offset(x: -geometry.size.width / 4, y: -geometry.size.height / 2)
                
                
                VStack(alignment: .center) {
                    //DateView()
                    ZStack {
                        //var n: Int = 0
                        ForEach(flashcards) { card in
                            //CardView{
                            //Text("card")
                            
                                CardViewSlide(card: card,totalCard: totalCards, currentCard: totalCards - flashcards.firstIndex(of: card)!, onRemove: { card in
                                    flashcards.removeAll { $0 == card }
                                })
                                    .animation(.spring())
                                    .frame(width: 350, height: 600)
                                    .offset(x: geometry.size.width / 4 - 25, y: self.getCardOffset(geometry, id: card.id.recordName))
                            
                            
                            //                            } back: {
                            //                                Text("aloha")
                            //                            }
   
                        }
 
                    }
                    
                    //.padding()
                    //Spacer()
                }
            }
            
        }
        //.padding()
        .onAppear() {
            CloudKitManager.shared.fetchDeck(deckID: deck.myrecord.recordID) { Result in
                switch Result {
                case .success(let cards):
                    var uniqueCards: Set<FlashCard> = []
                    self.flashcards = cards.filter({ card in
                        if uniqueCards.contains(card){
                            return false
                        }else {
                            uniqueCards.insert(card)
                            return true
                        }
                    })
                    self.totalCards = self.flashcards.count
                    print("Uhul da slide")
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
