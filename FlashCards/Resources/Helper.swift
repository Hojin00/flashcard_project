//
//  Helper.swift
//  FlashCards
//
//  Created by Hojin Ryu on 28/10/21.
//

import Foundation
import SwiftUI


enum SortBy: String {

    case lastSeen, lastUpdated, alphabet, hadest, hardest, importance, importanceAlphabet,  none
    
    var id: String { self.rawValue }
    
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
        case .importance:
            return [NSSortDescriptor(key: "importance", ascending: withAscending)]
        case .importanceAlphabet:
            return [NSSortDescriptor(key: "importance", ascending: withAscending), NSSortDescriptor(key: "title", ascending: true)]
        default:
            return []
        }
    }
}
