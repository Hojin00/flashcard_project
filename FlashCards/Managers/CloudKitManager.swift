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
    
    private let publicDB = CKContainer.default().publicCloudDatabase
    
    static let shared: CloudKitManager = CloudKitManager()

    @Published var decksCount = 0
    @Published var allDecks: [Deck] = []
    @Published var allImportantDecks: [Deck] = []
    @Published var allFlashCards: [FlashCard] = []
    
    
    private var allDecksCursor:CKQueryOperation.Cursor?
    private var allImportantDecksCursor:CKQueryOperation.Cursor?
    private var allFlashCardsCursor:CKQueryOperation.Cursor?
    
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
    func fetchNextDeckSortBy(sortType: SortBy, completionQueue: DispatchQueue = .main, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let allDecksCursor = allDecksCursor else {
            print("no cursor")
            return
        }

        let queryOperation = CKQueryOperation(cursor: allDecksCursor)
        switch sortType {
        case .lastSeen:
            queryOperation.resultsLimit = 1
        case .lastUpdated:
            queryOperation.resultsLimit = 2
        case .alphabet:
            queryOperation.resultsLimit = 3
        default:
            print("no sortDescriptors")
        }
        
        
        
        queryOperation.recordFetchedBlock = { record in
            let deck = Deck.init(record: record)
            
            
            DispatchQueue.main.async {
                
                self.allDecks.append(deck)
                switch sortType {
                case .hadest:
                    self.allDecks = self.allDecks.sorted(by: { ($0.flashcards ?? []).count > ($1.flashcards ?? []).count })
                default:
                    print("sortType")
                }
            }
        }
    
        
        queryOperation.queryCompletionBlock = { cursor, error in
            completionQueue.async {
                
                self.allDecksCursor = cursor
                
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
        
        publicDB.add(queryOperation)

//        self.publicDB.perform(query, inZoneWith: nil) { results, error in
//
//            if let error = error {
//                DispatchQueue.main.async {
//                    completion(.failure(error))
//                }
//                return
//            }
//
//            guard let results = results else {
//                DispatchQueue.main.async {
//                    let error = NSError(
//                        domain: "hojinRyu.FlashCard", code: -1,
//                        userInfo: [NSLocalizedDescriptionKey: "Could not download notes"])
//                    completion(.failure(error))
//                }
//                return
//            }
//
//            let deck = results.map{ Deck.init(record: $0) }
//
//
//            completionQueue.async {
//
//                completion(.success(deck))
//
//                switch sortType {
//                case .hadest:
//                    self.allDecks = deck.sorted(by: { ($0.flashcards ?? []).count > ($1.flashcards ?? []).count })
//                case .importanceAlphabet:
//                    self.allDecks = deck
//                default:
//                    self.allDecks = deck
//                }
//            }
//        }
        
    }
    
    //MARK: - Fetch All Decks with sortby
    func fetchDeckSortBy(sortType: SortBy, completionQueue: DispatchQueue = .main, completion: @escaping (Result<Void, Error>) -> Void) {
        
        
        let predicate = NSPredicate(value: true)
        
        // Using CKQueryOperation, the records will come in via the closure one at a time.
        // Store results in a temporary array for returning after completion.
        
        
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
        
        let queryOperation = CKQueryOperation(query: query)
        switch sortType {
        case .lastSeen:
            queryOperation.resultsLimit = 1
        case .lastUpdated:
            queryOperation.resultsLimit = 2
        case .alphabet:
            queryOperation.resultsLimit = 3
        default:
            print("no resultsLimit")
        }
        
        var fetchedDecks: [Deck] = []
        
        
        queryOperation.recordFetchedBlock = { record in
            let deck = Deck.init(record: record)
            fetchedDecks.append(deck)
            
            DispatchQueue.main.async {
                self.allDecks = []
                switch sortType {
                case .hadest:
                    self.allDecks = fetchedDecks.sorted(by: { ($0.flashcards ?? []).count > ($1.flashcards ?? []).count })
                case .importanceAlphabet:
                    self.allDecks = fetchedDecks
                default:
                    self.allDecks = fetchedDecks
                }
            }
        }
    
        
        queryOperation.queryCompletionBlock = { cursor, error in
            
            completionQueue.async {
                
                self.allDecksCursor = cursor
                
                
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
                
            }
        }
        
        publicDB.add(queryOperation)

//        self.publicDB.perform(query, inZoneWith: nil) { results, error in
//
//            if let error = error {
//                DispatchQueue.main.async {
//                    completion(.failure(error))
//                }
//                return
//            }
//
//            guard let results = results else {
//                DispatchQueue.main.async {
//                    let error = NSError(
//                        domain: "hojinRyu.FlashCard", code: -1,
//                        userInfo: [NSLocalizedDescriptionKey: "Could not download notes"])
//                    completion(.failure(error))
//                }
//                return
//            }
//
//            let deck = results.map{ Deck.init(record: $0) }
//
//
//            completionQueue.async {
//
//                completion(.success(deck))
//
//                switch sortType {
//                case .hadest:
//                    self.allDecks = deck.sorted(by: { ($0.flashcards ?? []).count > ($1.flashcards ?? []).count })
//                case .importanceAlphabet:
//                    self.allDecks = deck
//                default:
//                    self.allDecks = deck
//                }
//            }
//        }
        
    }
    
    //MARK: - Fetch All Flashcards of a Deck
    
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
                                self.allFlashCards = flashcards
                                // willian: ta printando 3vezes aqui
//                                print("here: ", self.allFlashCards.count)
//                                print("all: ", self.allFlashCards)
                            }
                        default:
                            print(error?.localizedDescription)
                            print("no flashcards in deck")
                        }
                    }
                }
            }
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

