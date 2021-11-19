//
//  SlideView.swift
//  FlashCards
//
//  Created by Willian Magnum Albeche on 20/10/21.
//

import SwiftUI
import AVFoundation
import CloudKit



struct CardDemo: Hashable, CustomStringConvertible, Identifiable {
    var id:Int
    let title: String
    let image: String
    let description: String
    //    var description: String {
    //        return "\(title), id: \(id)"
    //    }
}

struct SlideView: View {
    
    
    @State var flashcardsMockDemo:[CardDemo] = [CardDemo.init(id: 1, title: "Heart", image: "Heart", description: "What is it function on the body"), CardDemo.init(id: 2, title: "Brain", image: "Brain", description: "Where is the frontal lobe?"), CardDemo.init(id: 3, title: "Eye", image: "Eye", description: "How does the cornea work?"), CardDemo.init(id: 4, title: "Ribs", image: "Bones", description: "How many ribs do we have?")]
    
    // @EnvironmentObject private var cloudkitManager: CloudKitManager
    @State private var flashcards:[FlashCard] = []
    @State private var totalCards:Int = 4
    /// List of users EXEMPLO TROCAR DEPOIS POR FLASH CARD
    var deck: Deck
    init(deck: Deck){
        self.deck = deck
    }
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
    //       private func getCardOffset(_ geometry: GeometryProxy, id: String) -> CGFloat {
    //           guard let index = flashcards.firstIndex(where: {$0.id.recordName == id}) else {return 0}
    //           print(id, index)
    //           return  CGFloat((flashcards).count - index) * -20
    //       }
    
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(flashcardsMockDemo.count - 1 - id) * -10
    }
    
    var body: some View {
        
        
        GeometryReader { geometry in
            // 5
            LinearGradient(gradient: Gradient(colors: [Color("homeGradientGray1"), Color("homeGradientGray2")]), startPoint: .bottom, endPoint: .top)
                .frame(width: geometry.size.width * 1.5, height: geometry.size.height)
                .background(Color.blue)
                .clipShape(Circle())
                .offset(x: -geometry.size.width / 4, y: -geometry.size.height / 2)
            VStack {
                
                
                // 6
                ZStack {
                    
                    //                        HStack(alignment: .center) {
                    //                            Text("Cards are Over!")
                    //                                .offset(x: 100, y: 100)
                    //                        }
                    // 7
                    ForEach(flashcardsMockDemo) { card in
                        CardViewSlide(card: card,totalCard: totalCards, currentCard:  totalCards - flashcardsMockDemo.firstIndex(of: card)!
                                      , onRemove: { card in
                            flashcardsMockDemo.removeAll { $0 == card }
                        })
                            .animation(.spring())
                            .frame(width: 300, height: 500)
                            .offset(x: geometry.size.width / 2 - 150, y: self.getCardOffset(geometry, id: card.id))
                    }
                    if flashcardsMockDemo.count == 0 {
                        HStack(alignment: .center) {
                            Text("Cards are Over!")
                                .font(.body)
                                
                                .fontWeight(.black)
                                .offset(x: geometry.size.width / 4 + 20  , y: geometry.size.height / 2)
                        }
                        Spacer()
                    }
                }
                Spacer()
            }
        }
        
    }
}

struct SlideView_Previews: PreviewProvider {
    static var previews: some View {
        SlideView(deck: Deck.init(record: CKRecord.init(recordType: "Deck")))
    }
}
