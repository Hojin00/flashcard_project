//
//  FlashCardModel.swift
//  FlashCards
//
//  Created by João Brentano on 13/10/21.
//

import Foundation
import SwiftUI
import CloudKit

struct FlashCard: Hashable {
    var myrecord: CKRecord
    var title: String?
    var frontSideText: String?
    var frontSideImage: CKAsset?
    var backSideText: String?
    var backSideImage: CKAsset?
    var category: String?
    var frontSideAudio: CKAsset?
    var backSideAudio: CKAsset?
    var frontSideColor: CKAsset?
    var backSideColor: CKAsset?
    var hard: String?
    
    init(myrecord: CKRecord, title: String?, frontSideText: String?, frontSideImage: CKAsset?, backSideText: String?, backSideImage: CKAsset?, category: String?, frontSideAudio: CKAsset?, backSideAudio: CKAsset?, frontSideColor: CKAsset?, backSideColor: CKAsset?, hard: String?) {
        
        self.myrecord = myrecord
        self.title = title
        self.frontSideText = frontSideText
        self.backSideText = backSideText
        self.frontSideImage = frontSideImage
        self.backSideImage = backSideImage
        self.category = category
        self.frontSideAudio = frontSideAudio
        self.backSideAudio = backSideAudio
        self.frontSideColor = frontSideColor
        self.backSideColor = backSideColor
        self.hard = hard
        
        myrecord["title"] = title
        myrecord["frontSideText"] = frontSideText
        myrecord["backSideText"] = backSideText
        myrecord["frontSideImage"] = frontSideImage
        myrecord["backSideImage"] = backSideImage
        myrecord["category"] = frontSideText
        myrecord["frontSideAudio"] = frontSideAudio
        myrecord["backSideAudio"] = backSideAudio
        myrecord["frontSideColor"] = frontSideColor
        myrecord["backSideColor"] = backSideColor
        myrecord["hard"] = hard
        
    }
    
    init(record: CKRecord) {
        self.myrecord = record
        self.title = record["title"]
        self.frontSideText = record["frontSideText"]
        self.backSideText = record["backSideText"]
        self.frontSideImage = record["frontSideImage"]
        self.backSideImage = record["backSideImage"]
        self.category = record["category"]
        self.frontSideAudio = record["frontSideAudio"]
        self.backSideAudio = record["backSideAudio"]
        self.frontSideColor = myrecord["frontSideColor"]
        self.backSideColor = myrecord["backSideColor"]
        self.hard = myrecord["hard"]
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(myrecord.recordID)
    }
}
