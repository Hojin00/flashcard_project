//
//  Helper.swift
//  FlashCards
//
//  Created by Hojin Ryu on 28/10/21.
//

import Foundation


enum SortBy: String {
    case lastSeen, lastUpdated, alphabet, hadest, hardest
    
    var id: String { self.rawValue }
    static var emtpy: [NSSortDescriptor] { [] }
    
    func getSortBy(withAscending: Bool) -> [NSSortDescriptor] {
        switch self {
        case .lastSeen:
            return [NSSortDescriptor(key: "lastView", ascending: withAscending)]
        case .lastUpdated:
            return [NSSortDescriptor(key: "modificationDate", ascending: withAscending)]
        case .alphabet:
            return [NSSortDescriptor(key: "title", ascending: withAscending)]
        case .hardest:
            return [NSSortDescriptor(key: "hardFlashcards", ascending: withAscending)]
        default:
            return []
        }
    }
    
    func getSortByFlashCardCount(sort: [Deck]) -> [Deck] {
        return sort.sorted(by: { ($0.flashcards ?? []).count > ($1.flashcards ?? []).count })
    }
}
