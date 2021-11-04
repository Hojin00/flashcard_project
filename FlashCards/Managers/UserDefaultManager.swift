//
//  DateManager.swift
//  FlashCards
//
//  Created by Hojin Ryu on 18/10/21.
//

import Foundation

class UserDefaultManager {
    
    static let shared: UserDefaultManager = UserDefaultManager()
    var userDecks = [flashCardMock]()
    
//    func saveUserDecks() {
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(userDecks) {
//            let defaults = UserDefaults.standard
//            defaults.set(encoded, forKey: "gender")
//        }
//        UserDefaults.standard.set(userDecks, forKey: "userDecks")
//    }
//    
//    func loadUserDecks() {
//        userDecks = (UserDefaults.standard.array(forKey: "userDecks") as? [Deck]) ?? []
//    }
    
}
