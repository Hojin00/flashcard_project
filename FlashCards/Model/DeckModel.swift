//
//  DeckModel.swift
//  FlashCards
//
//  Created by Lucca Molon on 13/10/21.
//

import Foundation

struct Deck: Hashable {
    var flashcards: [FlashCard]
    var title: String
    var Category: String
    var reminderDate: Date?
}
