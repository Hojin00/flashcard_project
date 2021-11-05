//
//  ShareManager.swift
//  FlashCards
//
//  Created by Hojin Ryu on 19/10/21.
//

import Foundation
import CloudKit

class ShareManager {
    
    static let shared: ShareManager = ShareManager()
    var copyDecks = [Deck]()
    
    func copyDeck(_ deck: CKRecord.ID) {
        
    }
}
