//
//  CloudKitManager.swift
//  FlashCards
//
//  Created by Hojin Ryu on 15/10/21.
//

import Foundation
import CloudKit
import SwiftUI
import UIKit

class CloudKitManager: ObservableObject {
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    static let shared: CloudKitManager = CloudKitManager()
    
    @Published var allDecks: [Deck] = []
    @Published var allDecksImportant: [Deck] = []
    @Published var allFlashCards: [FlashCard] = []
    
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
            print(results)
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

                    if let error = error{
                        print(error.localizedDescription)
                        return
                    }
                }
            }
        }
    }
    
    //MARK: - Fetch All Decks with sortby
    func fetchDeckSortBy(sortType: SortBy, completionQueue: DispatchQueue = .main, completion: @escaping (Result<[Deck], Error>) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Deck", predicate: predicate)

        switch sortType {
        case .lastSeen:
            query.sortDescriptors = sortType.getSortBy(withAscending: false)
        case .lastUpdated:
            query.sortDescriptors = sortType.getSortBy(withAscending: false)
        case .alphabet:
            query.sortDescriptors = sortType.getSortBy(withAscending: true)
        case .hardest:
            query.sortDescriptors = sortType.getSortBy(withAscending: false)
        case .importance:
            query.sortDescriptors = sortType.getSortBy(withAscending: false)
        case .importanceAlphabet:
            query.sortDescriptors = sortType.getSortBy(withAscending: false)
        default:
            print("no sortDescriptors")
        }
        

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
            
            
            completionQueue.async {

                completion(.success(deck))
                
                switch sortType {
                case .hadest:
                    self.allDecks = deck.sorted(by: { ($0.flashcards ?? []).count > ($1.flashcards ?? []).count })
                case .importanceAlphabet:
                    self.allDecksImportant = deck
                default:
                    self.allDecks = deck
                }
            }
        }
    }
    
    //MARK: - Fetch All Flashcards of a Deck
    
    func fetchDeck(deckID: CKRecord.ID, completionQueue: DispatchQueue = .main, completion: @escaping (Result<[FlashCard], Error>) -> Void) {
        //TODO
        //when no deck id encountered, print("no deck id exists")
        
        self.publicDB.fetch(withRecordID: deckID) { record, error in

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }


            
            guard let record = record else{
                DispatchQueue.main.async {
                    let error = NSError(
                        domain: "hojinRyu.FlashCard", code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Could not download notes"])
                    completion(.failure(error))
                }
                return
                
            }
            let deck = Deck.init(record: record)
            let cardIDs = deck.flashcards?.map({$0.recordID}) ?? []
            
            let operation = CKFetchRecordsOperation(recordIDs: cardIDs)
            operation.fetchRecordsCompletionBlock = {recordMap , error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
                let cards = (cardIDs).compactMap { cardReference -> FlashCard? in
                    if let cardRecord = recordMap?[cardReference]{
                        return FlashCard.init(record: cardRecord)
                    }
                    return nil
                }
                DispatchQueue.main.async {
                    completion(.success(cards))
                    self.allFlashCards = cards
                }
            }
            self.publicDB.add(operation)
            
        }
    }
    
    // MARK: Return a flashcard with ID
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

