//
//  CloudKitManager.swift
//  FlashCards
//
//  Created by Hojin Ryu on 15/10/21.
//

import Foundation
import CloudKit
import SwiftUI

class CloudKitManager: ObservableObject {
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    static let shared: CloudKitManager = CloudKitManager()
    
    @Published var allDecks: [Deck] = []
    
    // MARK: TODO
    // duplicate FlashCard
    // duplicate Deck
    
    
    func createFlashCard(flashCard: CKRecord) {

        self.publicDB.save(flashCard) { (savedRecord, error) in

            guard let _ = savedRecord else {

                print( "Flash Card not saved")
                return
            }

            print("Flash Card saved")
            if let error = error{
                print(error.localizedDescription)
                return
            }
        }
    }

    func deleteFlashCard(flashCard: CKRecord) {

        self.publicDB.delete(withRecordID: flashCard.recordID) { (savedRecordID, error) in

            guard let _ = savedRecordID else {

                print( "FlashCard not deleted")
                return
            }

            print("\(savedRecordID!.recordName) deleted")
            if let error = error{
                print(error.localizedDescription)
                return
            }
        }
    }

    func fetchAllFlashCards(completionQueue: DispatchQueue = .main, completion: @escaping (Result<[FlashCard], Error>) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "FlashCard", predicate: predicate)

        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        self.publicDB.perform(query, inZoneWith: nil) { results, error in

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let results = results else {
                DispatchQueue.main.async {
                    let error = NSError(
                        domain: "hojinRyu.FlashCard", code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Could not download notes"])
                    completion(.failure(error))
                }
                return
            }

            let flashCards = results.map{ FlashCard.init(record: $0) }

            completionQueue.async {

                completion(.success(flashCards))

            }
        }
    }

    func updateFlashCard(flashCard: FlashCard) {

        self.publicDB.fetch(withRecordID: flashCard.myrecord.recordID) { updateRecord, error in
            if error == nil {
                guard let auxUpdateRecord = updateRecord else {return}
                auxUpdateRecord.setValue(flashCard.frontSideText, forKey: "frontSideText")
                auxUpdateRecord.setValue(flashCard.backSideText, forKey: "backSideText")
                auxUpdateRecord.setValue(flashCard.frontSideImage, forKey: "frontSideImage")
                auxUpdateRecord.setValue(flashCard.backSideImage, forKey: "backSideImage")
                auxUpdateRecord.setValue(flashCard.frontSideAudio, forKey: "frontSideAudio")
                auxUpdateRecord.setValue(flashCard.backSideAudio, forKey: "backSideAudio")
                auxUpdateRecord.setValue(flashCard.category, forKey: "category")

                self.publicDB.save(auxUpdateRecord) { (savedRecord, error) in

                    guard let _ = savedRecord else {

                        print( "flashcard not updated")
                        return
                    }

                    print("flashcard updated")

//                    UserDefaultManager.shared.saveUserDecks()

                    if let error = error{
                        print(error.localizedDescription)
                        return
                    }
                }
            }
        }
    }

    func createDeck(deck: CKRecord) {

        self.publicDB.save(deck) { (savedRecord, error) in

            guard let _ = savedRecord else {

                print( "deck not saved")
                return
            }

            print("deck saved")

//            UserDefaultManager.shared.userDecks.append(deck)
//            UserDefaultManager.shared.saveUserDecks()

            if let error = error{
                print(error.localizedDescription)
                return
            }
        }
    }

    func deleteDeck(deck: CKRecord) {

        self.publicDB.delete(withRecordID: deck.recordID) { (savedRecordID, error) in

            guard let _ = savedRecordID else {

                print( "deck not deleted")
                return
            }

            print("\(savedRecordID!.recordName) deleted")
            if let error = error{
                print(error.localizedDescription)
                return
            }
        }
    }

    func fetchAllDecks(completionQueue: DispatchQueue = .main, completion: @escaping (Result<[Deck], Error>) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Deck", predicate: predicate)

        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        self.publicDB.perform(query, inZoneWith: nil) { results, error in

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let results = results else {
                DispatchQueue.main.async {
                    let error = NSError(
                        domain: "hojinRyu.FlashCard", code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Could not download notes"])
                    completion(.failure(error))
                }
                return
            }

            let decks = results.map{ Deck.init(record: $0) }
            
            completionQueue.async {

                completion(.success(decks))
                self.allDecks = decks

            }
        }
    }

    func updateDeck(deck: Deck) {

        self.publicDB.fetch(withRecordID: deck.myrecord.recordID) { updateRecord, error in
            if error == nil {
                guard let auxUpdateRecord = updateRecord else {return}
                auxUpdateRecord.setValue(deck.flashcards, forKey: "flashCardList")
                auxUpdateRecord.setValue(deck.title, forKey: "title")
                auxUpdateRecord.setValue(deck.category, forKey: "category")
                auxUpdateRecord.setValue(deck.reminderDate, forKey: "reminderDate")

                self.publicDB.save(auxUpdateRecord) { (savedRecord, error) in

                    guard let _ = savedRecord else {

                        print( "deck not updated")
                        return
                    }

                    print("deck updated")

//                    UserDefaultManager.shared.saveUserDecks()

                    if let error = error{
                        print(error.localizedDescription)
                        return
                    }
                }
            }
        }
    }
    
    //MARK: - Fetch All Flashcards de um Deckw
    
    func fetchDeck(deckID: CKRecord.ID, completionQueue: DispatchQueue = .main, completion: @escaping (Result<[FlashCard], Error>) -> Void) {
        //TODO
        //when no deck id encountered, print("no deck id exists")
        let predicate = NSPredicate(format: "recordID == %@", argumentArray: [deckID])
        let query = CKQuery(recordType: "Deck", predicate: predicate)

        self.publicDB.perform(query, inZoneWith: nil) { results, error in

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let results = results else {
                DispatchQueue.main.async {
                    let error = NSError(
                        domain: "hojinRyu.FlashCard", code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Could not download notes"])
                    completion(.failure(error))
                }
                return
            }

            let deck = results.map{ Deck.init(record: $0) }
            
            
            for d in deck {
                for f in d.flashcards ?? [] {
                    self.fetchDeckFlashcards(flashcardID: f.recordID) { Result in
                        switch Result {
                        case .success(let flashcards):
                            completionQueue.async {
                                completion(.success(flashcards))
                            }
                        default:
                            print("no flashcards in deck")
                        }
                    }
                }
            }
        }
    }
    
    func fetchDeckFlashcards(flashcardID: CKRecord.ID, completionQueue: DispatchQueue = .main, completion: @escaping (Result<[FlashCard], Error>) -> Void) {
        
        let predicate = NSPredicate(format: "recordID == %@", argumentArray: [flashcardID] )
        let query = CKQuery(recordType: "FlashCard", predicate: predicate)

//        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        self.publicDB.perform(query, inZoneWith: nil) { results, error in

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let results = results else {
                DispatchQueue.main.async {
                    let error = NSError(
                        domain: "hojinRyu.FlashCard", code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Could not download notes"])
                    completion(.failure(error))
                }
                return
            }

            let flashcards = results.map{ FlashCard.init(record: $0) }
        
            completionQueue.async {

                completion(.success(flashcards))

            }
        }
    }
}

