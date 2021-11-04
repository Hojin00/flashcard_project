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
    let deck = Deck.init(record: CKRecord.init(recordType: "Deck"))
    
    var body: some View {
       SlideView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
