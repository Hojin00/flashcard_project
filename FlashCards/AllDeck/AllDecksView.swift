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
                        EmptyView()
                    }
                case 1:
                    HStack {
                        NewDeckView()
                        SingleDeckView(deck: decks[0])
                    }
                case 2:
                    HStack {
                        NewDeckView()
                        SingleDeckView(deck: decks[0])
                    }
                    HStack {
                        SingleDeckView(deck: decks[1])
                        EmptyView()
                    }
                default:
                    HStack {
                        NewDeckView()
                        SingleDeckView(deck: decks[0])
                    }
                    ForEach(1..<decks.count) { n in
                        HStack {
                            if n % 2 != 0 {
                                if n+1 < decks.count {
                                    SingleDeckView(deck: decks[n])
                                    SingleDeckView(deck: decks[n+1])
                                } else {
                                    SingleDeckView(deck: decks[n])
                                    EmptyView()
                                }
                            }
                        }
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
