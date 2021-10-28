//
//  AllDecksView.swift
//  FlashCards
//
//  Created by João Brentano on 22/10/21.
//

import SwiftUI
import CloudKit

struct AllDecksView: View {
    
    var decks: [Deck]
    
    init(decks: [Deck]) {
        self.decks = decks
        
    }
    
    var body: some View {
        ScrollView {
            VStack {
                switch decks.count {
                case 0:
                    HStack {
                        NewDeckView()
                    }
                case 1:
                    HStack {
                        NewDeckView()
                        DeckView(deck: decks[0])
                    }
                default:
                    HStack {
                            
                    }
                }
            }
        }
    }
}

struct AllDecksView_Previews: PreviewProvider {
    static var previews: some View {
        AllDecksView(decks: [Deck.init(record: CKRecord.init(recordType: "Deck"))])
    }
}
