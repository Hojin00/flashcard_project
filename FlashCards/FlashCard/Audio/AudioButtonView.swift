//
//  AudioButtonView.swift
//  FlashCards
//
//  Created by Hojin Ryu on 20/10/21.
//

import Foundation
import SwiftUI
import CloudKit

struct AudioButtonView: View {
    
    @ObservedObject var audioRecorder: AudioRecorder = AudioRecorder()
    let auxRecord = CKRecord.init(recordType: "FlashCard")
    let auxRecord3 = CKRecord.init(recordType: "FlashCard")
    let auxRecord2 = CKRecord.init(recordType: "Deck")
    
    @State var FlashCardReferenceList = [CKRecord.Reference]()
    @State var flashCardList = [FlashCard]()
    
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
                    
                    let auxFlashCard = FlashCard.init(myrecord: auxRecord, frontSideText: "frontText", frontSideImage: nil, backSideText: "backText", backSideImage: nil, category: "category", frontSideAudio: recordAudio, backSideAudio: nil, frontSideColor: nil, backSideColor: nil)
                    
                    CloudKitManager.shared.createFlashCard(flashCard: auxFlashCard.myrecord)
                    
                }
                Button("create deck") {
                    
                    let auxDeck = flashCardMock.init(myrecord: auxRecord2, flashcards: FlashCardReferenceList, title: "deck title", category: "deck category", reminderDate: Date())
                    
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
        .navigationBarTitle("Voice recorder")
        .navigationBarItems(trailing: EditButton())
    }
}

struct AudioButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AudioButtonView()
    }
}



