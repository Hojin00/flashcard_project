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

    var body: some View {
        SlideView(deck: Deck.init(record: CKRecord.init(recordType: "Deck")))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
