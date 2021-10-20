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
    
    var notificationManager = NotificationManager()
    let auxRecord = CKRecord.init(recordType: "FlashCard")
    let auxRecord3 = CKRecord.init(recordType: "FlashCard")
    let auxRecord2 = CKRecord.init(recordType: "Deck")
    
    @State var FlashCardReferenceList = [CKRecord.Reference]()
    @State var flashCardList = [FlashCard]()
    
    var body: some View {
        
        VStack {
            //            ShareView()
            //
            //            Button("auth") {
            //                notificationManager.authorization()
            //            }
            //            Divider()
            //            Button("aa") {
            //                notificationManager.send(identifier: UUID().uuidString, title: "hello friend", body: "how r u? XD", hour: 16, minute: 45)
            //                print("teste")
            //                notificationManager.notificationCenter.getPendingNotificationRequests(completionHandler: { requests in
            //                    for request in requests {
            //                        print(request)
            //                    }
            //                }
            //                )
            //            }
            //            Divider()
            //            Button("delete all notifications") {
            //                notificationManager.stopSending()
            //            }
            //
            
            
            Button("create flashcard") {
                
                let auxFlashCard = FlashCard.init(myrecord: auxRecord, frontSideText: "frontText", frontSideImage: nil, backSideText: "backText", backSideImage: nil, category: "category", frontSideAudio: nil, backSideAudio: nil)
                let auxFlashCard2 = FlashCard.init(myrecord: auxRecord3, frontSideText: "frontText", frontSideImage: nil, backSideText: "backText", backSideImage: nil, category: "category", frontSideAudio: nil, backSideAudio: nil)
                CloudKitManager.shared.createFlashCard(flashCard: auxFlashCard.myrecord)
                CloudKitManager.shared.createFlashCard(flashCard: auxFlashCard2.myrecord)
                
                flashCardList.append(auxFlashCard)
                flashCardList.append(auxFlashCard2)
                
                let auxReference = CKRecord.Reference.init(recordID: auxFlashCard.myrecord.recordID, action: .none)
                FlashCardReferenceList.append(auxReference)
                
                let auxReference2 = CKRecord.Reference.init(recordID: auxFlashCard2.myrecord.recordID, action: .none)
                FlashCardReferenceList.append(auxReference2)
                
            }
            
            Button("create deck") {
                
                let auxDeck = Deck.init(myrecord: auxRecord2, flashcards: FlashCardReferenceList, title: "deck title", category: "deck category", reminderDate: Date())
                
                CloudKitManager.shared.createDeck(deck: auxDeck.myrecord)
                
            }
            Button("fetch deck flashcards") {
                
                
                CloudKitManager.shared.fetchDeck(deckID: CKRecord.ID.init(recordName: "DBEF706B-8DFC-473C-971B-E49BE3BEB807")) { Result in
                    switch Result {
                    case .success(let flashcard):
                        print(flashcard)
                    default:
                        print("no decks")
                    }
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
