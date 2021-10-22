//
//  DateManager.swift
//  FlashCards
//
//  Created by Hojin Ryu on 18/10/21.
//

import Foundation
import CloudKit

class UserDefaultsManager {
    
    static let shared: UserDefaultsManager = UserDefaultsManager()
    var userDecks = [Deck]()
    var myrecordIDs = [String]()
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
    
    func saveMyRecords(recordID: [CKRecord.ID]) {
        myrecordIDs.removeAll()
        
        myrecordIDs.append("\(recordID)")
        UserDefaults.standard.set("\(recordID)", forKey: "myRecord")
    }
    
}
//
//CKContainer.default().fetchUserRecordID { userID, error in
//    guard let userID = userID else { return }
//    let reference = CKRecord.Reference.init(recordID: userID, action: .none)
//    let predicate = NSPredicate(format: "creatorUserRecordID == %@", reference)
//    let query = CKQuery(recordType: "FlashCard", predicate: predicate)
//
//}
