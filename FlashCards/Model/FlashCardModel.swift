//
//  FlashCardModel.swift
//  FlashCards
//
//  Created by João Brentano on 13/10/21.
//

import Foundation
import SwiftUI
import CloudKit

struct FlashCard: Hashable, Identifiable {
    let id: CKRecord.ID
    var myrecord: CKRecord
    var frontSideTitle: String?
    var backSideTitle: String?
    var frontSideText: String?
    var frontSideImage: CKAsset?
    var backSideText: String?
    var backSideImage: CKAsset?
    var category: String?
    var frontSideAudio: CKAsset?
    var backSideAudio: CKAsset?
    var hard: String?
    
    private init(){
        let newFlashCard = CKRecord.init(recordType: "FlashCard")
        
        myrecord = newFlashCard
        id = newFlashCard.recordID
    }
    
    init(myrecord: CKRecord, frontSideTitle: String?, backSideTitle: String?, frontSideText: String?, frontSideImage: CKAsset?, backSideText: String?, backSideImage: CKAsset?, category: String?, frontSideAudio: CKAsset?, backSideAudio: CKAsset?, hard: String?) {
        self.id = myrecord.recordID
        self.myrecord = myrecord
        self.frontSideTitle = frontSideTitle
        self.backSideTitle = backSideTitle
        self.frontSideText = frontSideText
        self.backSideText = backSideText
        self.frontSideImage = frontSideImage
        self.backSideImage = backSideImage
        self.category = category
        self.frontSideAudio = frontSideAudio
        self.backSideAudio = backSideAudio
        self.hard = hard
        
        
        myrecord["frontSideTitle"] = frontSideTitle
        myrecord["backSideTitle"] = backSideTitle
        myrecord["frontSideText"] = frontSideText
        myrecord["backSideText"] = backSideText
        myrecord["frontSideImage"] = frontSideImage
        myrecord["backSideImage"] = backSideImage
        myrecord["category"] = frontSideText
        myrecord["frontSideAudio"] = frontSideAudio
        myrecord["backSideAudio"] = backSideAudio
        myrecord["hard"] = hard
        
    }
    
    init(record: CKRecord) {
        self.id = record.recordID
        self.myrecord = record
        self.frontSideTitle = record["frontSideTitle"]
        self.backSideTitle = record["backSideTitle"]
        self.frontSideText = record["frontSideText"]
        self.backSideText = record["backSideText"]
        self.frontSideImage = record["frontSideImage"]
        self.backSideImage = record["backSideImage"]
        self.category = record["category"]
        self.frontSideAudio = record["frontSideAudio"]
        self.backSideAudio = record["backSideAudio"]
        self.hard = myrecord["hard"]
    }
    
    static func createEmptyFlashCard() -> FlashCard{
        return FlashCard.init()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
