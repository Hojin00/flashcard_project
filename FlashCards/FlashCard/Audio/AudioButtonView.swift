//
//  AudioButtonView.swift
//  FlashCards
//
//  Created by Hojin Ryu on 20/10/21.
//

import Foundation
import SwiftUI
import CloudKit
import AVFoundation

struct AudioButtonView: View {
    @EnvironmentObject private var cloudkitManager: CloudKitManager
    @ObservedObject var audioRecorder: AudioRecorder = AudioRecorder()
    let auxRecord = CKRecord.init(recordType: "FlashCard")
    let auxRecord3 = CKRecord.init(recordType: "FlashCard")
    let auxRecord2 = CKRecord.init(recordType: "Deck")
    
    
    @State var FlashCardReferenceList = [CKRecord.Reference]()
    @State var flashCardList = [FlashCard]()
    @State var auxDeck: Deck?
    
    @State var recordAudio: CKAsset?
    
    var body: some View {
        NavigationView{
            VStack {
                RecordingsListView(audioRecorder: audioRecorder)
                
                if audioRecorder.recording == false {
                    Button(action: { self.audioRecorder.startRecording() }) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                } else {
                    Button(action: {
                        self.audioRecorder.stopRecording()
                        
                        guard let record = self.audioRecorder.auxRecordings?.fileURL else { return }
                        recordAudio = CKAsset.init(fileURL: record)
                    }) {
                        Image(systemName: "stop.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                }
                
                Button("create flashcard") {
//                    guard let auxColor1 = Color.blue.toURL() else { return }
//                    let tes = CKAsset.init(fileURL: auxColor1)
                    
//                    let auxFlashCard = FlashCard.init(myrecord: auxRecord, title: "title1000", frontSideText: "frontText", frontSideImage: nil, backSideText: "backText", backSideImage: nil, category: "category", frontSideAudio: recordAudio, backSideAudio: nil, hard: "difficult".lowercased())
//                    
//                    let auxFlashCard2 = FlashCard.init(myrecord: CKRecord.init(recordType: "FlashCard"), title: "title2000", frontSideText: "frontText", frontSideImage: nil, backSideText: "backText", backSideImage: nil, category: "category", frontSideAudio: recordAudio, backSideAudio: nil, hard: "difficult")
//                    
//                    let auxFlashCard3 = FlashCard.init(myrecord: CKRecord.init(recordType: "FlashCard"), title: "title3000", frontSideText: "frontText", frontSideImage: nil, backSideText: "backText", backSideImage: nil, category: "category", frontSideAudio: recordAudio, backSideAudio: nil, hard: "difficult")
//                    
//                    
//                    
//                    
//                    CloudKitManager.shared.createFlashCard(flashCard: auxFlashCard.myrecord)
//                    CloudKitManager.shared.createFlashCard(flashCard: auxFlashCard2.myrecord)
//                    CloudKitManager.shared.createFlashCard(flashCard: auxFlashCard3.myrecord)
//                    
//                    FlashCardReferenceList.append(CKRecord.Reference.init(record: auxFlashCard.myrecord, action: .none))
//                    FlashCardReferenceList.append(CKRecord.Reference.init(record: auxFlashCard2.myrecord, action: .none))
//                    FlashCardReferenceList.append(CKRecord.Reference.init(record: auxFlashCard3.myrecord, action: .none))
//                    
//                    auxDeck = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
//                    
//                    CloudKitManager.shared.createDeck(deck: auxDeck!.myrecord)
                }
                
                NavigationLink(destination: DeckView(deck: auxDeck ?? Deck.init(record: CKRecord.init(recordType: "Deck")))) {
                    Text("create deck1")
                        
                }
                
                Button("create deck2") {
                    
//                    let auxDeck = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "555555", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 6, importance: 2, themeColor: "white")
//
//                    CloudKitManager.shared.createDeck(deck: auxDeck.myrecord)
                    
//                    CloudKitManager.shared.fetchDeckSortBy(sortType: SortBy.lastSeen) { Result in
//
//                        switch Result {
//                        case .success:
//                            print("success last seen")
//
//                        case .failure:
//                            print("no last seen")
//
//                        }
//                    }
                    guard let deckaux = auxDeck?.myrecord.recordID else { return }
                    cloudkitManager.fetchDeck(deckID: deckaux) { Result in
                        switch Result {
                        case .success:
                            print("success l")
                            
                        case .failure:
                            print("no las")
                            
                        }
                    }
                    
                    
                }
                Button("create deck3") {
                    auxDeck = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck!.myrecord)
                    
                    let auxDeck2 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck2.myrecord)
                    
                    let auxDeck3 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck3.myrecord)
                    
                    let auxDeck4 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck4.myrecord)
                    
                    let auxDeck5 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck5.myrecord)
                    
                    let auxDeck6 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck6.myrecord)
                    
                    let auxDeck7 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck7.myrecord)
                    
                    let auxDeck8 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck8.myrecord)
                    
                    let auxDeck9 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck9.myrecord)
                    
                    let auxDeck10 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck10.myrecord)
                    
                    let auxDeck11 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck11.myrecord)
                    
                    let auxDeck12 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck12.myrecord)
                    
                    let auxDeck13 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck13.myrecord)
                    
                    let auxDeck14 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck14.myrecord)
                    
                    let auxDeck15 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck15.myrecord)
                    
                    let auxDeck16 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck16.myrecord)
                    
                    let auxDeck17 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck17.myrecord)
                    
                    let auxDeck18 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck18.myrecord)
                    
                    let auxDeck19 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck19.myrecord)
                    
                    let auxDeck20 = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck20.myrecord)
                    
                    
//                    cloudkitManager.fetchNextDeckSortBy(sortType: SortBy.lastSeen) { Result in
//                        switch Result {
//                        case .success(_):
//                            print("success flash")
//
//                        case .failure:
//                            print("fail")
//                        }
//                    }
//                    let auxDeck = Deck.init(myrecord: auxRecord2, flashcards: FlashCardReferenceList, title: "44444", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 5, importance: 1, themeColor: "white")
//
//                    CloudKitManager.shared.createDeck(deck: auxDeck.myrecord)
                    
                    
                }
                Button("fetch deck flashcards") {
                    print("deck cards: \(cloudkitManager.allDecks.last?.title)")
//                    CloudKitManager.shared.fetchDeckSortBy(sortType: SortBy.hardest) { Result in
//                        switch Result {
//                        case .success(let decks):
//                            print(decks)
//                        default:
//                            print("no flashcards")
//                        }
//                    }
                    
                    
                }
            }
        }
        .navigationBarTitle("Voice recorder")
        .navigationBarItems(trailing: EditButton())
    }
}

struct AudioButtonView_Previews: PreviewProvider {
    
    static var previews: some View {
        AudioButtonView()
    }
}



