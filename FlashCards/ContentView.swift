//
//  ContentView.swift
//  FlashCards
//
//  Created by João Brentano on 13/10/21.
//

import SwiftUI
import CloudKit
import UIKit



struct ContentView: View {
    @State static private var flashcardMock = FlashCard(myrecord: CKRecord.init(recordType: "FlashCard"), frontSideText: "front text", frontSideImage: nil, backSideText: "back text", backSideImage: nil, category: nil, frontSideAudio: nil, backSideAudio: nil)
    
    static private var deckmock = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: [CKRecord.Reference.init(record: flashcardMock.myrecord, action: .none)], title: "deck title", category: "lk", reminderDate: Date())
    
    var body: some View {
        DeckView(deck: ContentView.deckmock)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





