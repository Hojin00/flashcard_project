//
//  DeckModel.swift
//  FlashCards
//
//  Created by Lucca Molon on 13/10/21.
//

import Foundation
import CloudKit

struct Deck: Hashable, Identifiable {
    var id: CKRecord.ID
    var myrecord: CKRecord
    var flashcards: [CKRecord.Reference]?
    var title: String?
    var category: String?
    var reminderDate: Date?
    var lastView: Date?
    var hardFlashcards: Int?

    init(myrecord: CKRecord, flashcards: [CKRecord.Reference]?, title: String?, category: String?, reminderDate: Date?, lastView: Date?, hardFlashcards: Int) {
        self.id = myrecord.recordID
        self.myrecord = myrecord
        self.flashcards = flashcards
        self.title = title
        self.category = category
        self.reminderDate = reminderDate
        self.lastView = lastView
        self.hardFlashcards = hardFlashcards

        myrecord["flashCardList"] = flashcards
        myrecord["title"] = title
        myrecord["category"] = category
        myrecord["reminderDate"] = reminderDate
        myrecord["lastView"] = lastView
        myrecord["hardFlashcards"] = hardFlashcards

    }

    init(record: CKRecord) {
        self.id = record.recordID
        self.myrecord = record
        self.flashcards = record["flashCardList"]
        self.title = record["title"]
        self.category = record["category"]
        self.reminderDate = record["reminderDate"]
        self.lastView = record["lastView"]
        self.hardFlashcards = record["hardFlashcards"]
        
        
    }
}

