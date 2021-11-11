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
                    
                    let auxFlashCard = FlashCard.init(myrecord: auxRecord, title: "title1000", frontSideText: "frontText", frontSideImage: nil, backSideText: "backText", backSideImage: nil, category: "category", frontSideAudio: recordAudio, backSideAudio: nil, hard: "difficult".lowercased())
                    
                    let auxFlashCard2 = FlashCard.init(myrecord: CKRecord.init(recordType: "FlashCard"), title: "title2000", frontSideText: "frontText", frontSideImage: nil, backSideText: "backText", backSideImage: nil, category: "category", frontSideAudio: recordAudio, backSideAudio: nil, hard: "difficult")
                    
                    let auxFlashCard3 = FlashCard.init(myrecord: CKRecord.init(recordType: "FlashCard"), title: "title3000", frontSideText: "frontText", frontSideImage: nil, backSideText: "backText", backSideImage: nil, category: "category", frontSideAudio: recordAudio, backSideAudio: nil, hard: "difficult")
                    
                    
                    
                    
                    CloudKitManager.shared.createFlashCard(flashCard: auxFlashCard.myrecord)
                    CloudKitManager.shared.createFlashCard(flashCard: auxFlashCard2.myrecord)
                    CloudKitManager.shared.createFlashCard(flashCard: auxFlashCard3.myrecord)
                    
                    FlashCardReferenceList.append(CKRecord.Reference.init(record: auxFlashCard.myrecord, action: .none))
                    FlashCardReferenceList.append(CKRecord.Reference.init(record: auxFlashCard2.myrecord, action: .none))
                    FlashCardReferenceList.append(CKRecord.Reference.init(record: auxFlashCard3.myrecord, action: .none))
                    
                    auxDeck = Deck.init(myrecord: CKRecord.init(recordType: "Deck"), flashcards: FlashCardReferenceList, title: "1234", category: "deck category", reminderDate: Date(), lastView: Date(), hardFlashcards: 1, importance: 0, themeColor: "white")
                    
                    CloudKitManager.shared.createDeck(deck: auxDeck!.myrecord)
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
                    cloudkitManager.fetchNextDeckSortBy(sortType: SortBy.lastSeen) { Result in
                        switch Result {
                        case .success(_):
                            print("success flash")
                            
                        case .failure:
                            print("fail")
                        }
                    }
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



