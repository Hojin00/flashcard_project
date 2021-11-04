//
//  AllDecksView.swift
//  FlashCards
//
//  Created by João Brentano on 22/10/21.
//

import SwiftUI
import CloudKit

struct AllDecksView: View {
    
    var decks: [flashCardMock]
    @State private var searchText: String = ""
    
    init(decks: [flashCardMock]) {
        self.decks = decks
    }
    
    var body: some View {
        ZStack {
            Circle()
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.size.width * 1.4, height: UIScreen.main.bounds.size.width * 1.4)
                .padding(.top, UIScreen.main.bounds.size.width * -1.3)
                .foregroundColor(.gray)
                .opacity(0.5)
            VStack {
                Text("All Decks")
                    .font(.title).bold()
                SearchBar(text: $searchText)
                    .frame(width: UIScreen.main.bounds.size.width * 0.95, height: UIScreen.main.bounds.size.height * 0.05, alignment: .center)
                ScrollView {
                    VStack {
                        switch decks.count {
                        case 0:
                            HStack {
                                NewDeckView()
                                AllDeckEmptyView()
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
                                AllDeckEmptyView()
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
                                            AllDeckEmptyView()
                                        }
                                    }
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
        AllDecksView(decks: [flashCardMock.init(record: CKRecord.init(recordType: "Deck"))])
    }
}
