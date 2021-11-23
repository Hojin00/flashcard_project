//
//  NewCardSideView.swift
//  FlashCards
//
//  Created by Lucca Molon on 03/11/21.
//

import SwiftUI
import AVFoundation
import CloudKit

struct NewCardSideView: View {
    
    var side: Side
    
    @Binding var frontSideTitle: String
    @Binding var frontSideText: String
    @Binding var frontSideAudio: CKAsset?
    @Binding var backSideTitle: String
    @Binding var backSideText: String
    @Binding var backSideAudio: CKAsset?
//    @State private var auxFlashCard: FlashCard
    
    var body: some View {
        VStack {
            if side == .front {
                Text("Front Side")
                frontSideSaveView(recordAudio: $frontSideAudio, title: $frontSideTitle, text: $frontSideText)
                
            } else {
                Text("Back Side")
                backSideSaveView(recordAudio: $backSideAudio, title: $backSideTitle, text: $backSideText)
            }
            
        }
        //.background(color)
    }
}

struct frontSideSaveView: View{
    @ObservedObject var audioRecorder: AudioRecorder = AudioRecorder()
    
    @State var recordAudioURL: [URL] = []
    let screenSize: CGSize = UIScreen.main.bounds.size
    @Binding var recordAudio: CKAsset?
    @Binding var title: String
    @Binding var text: String
    @State private var sliderValue: Double = 0
    @State private var isDeleted: Bool = false
    
    
//    var flashCard: FlashCard
    
    var body: some View{
        HStack {
            Text("Title")
                .padding(.leading, screenSize.width * 0.03)
            Spacer()
        }
        RoundedRectangle(cornerRadius: 5)
            .stroke(.gray, lineWidth: 1)
            .opacity(0.5)
            .frame(width: screenSize.width * 0.8, height: screenSize.height * 0.03)
            .overlay(
            TextField("Placeholder", text: $title)
                .padding(.leading, screenSize.width * 0.01)
        )
        HStack {
            Text("Image")
                .padding(.leading, screenSize.width * 0.03)
            Spacer()
        }
        Button() {
            print("aaaa")
        } label: {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: screenSize.width * 0.8, height: screenSize.height * 0.1)
                .foregroundColor(.gray)
                .opacity(0.5)
                .overlay(
                    Text("\(Image(systemName: "photo")) Add Image")
                        .foregroundColor(.black)
                )
        }
        HStack {
            Text("Short description or Question")
                .padding(.leading, screenSize.width * 0.03)
            Spacer()
        }
        RoundedRectangle(cornerRadius: 5)
            .stroke(.gray, lineWidth: 1)
            .opacity(0.5)
            .frame(width: screenSize.width * 0.8, height: screenSize.height * 0.14)
            .overlay(
                VStack {
                    TextEditor(text: $text)
                        .lineLimit(nil)
                        .padding([.leading, .top], screenSize.width * 0.01)
                    Spacer()
                }
            )
        HStack {
            Text("Audio")
                .padding(.leading, screenSize.width * 0.03)
            Spacer()
        }
        HStack {
            if audioRecorder.recording == false {
                Button(action: { self.audioRecorder.startRecording() }) {
                    Image(systemName: "mic")
                        .padding(.leading, screenSize.width * 0.02)
                        .foregroundColor(Color.gray)
                }
        

            } else {
                Button(action: {
                    self.audioRecorder.stopRecording()
                    
                    guard let record = self.audioRecorder.auxRecordings?.fileURL else { return }
                    recordAudio = CKAsset.init(fileURL: record)
                    recordAudioURL.append(record)
                    isDeleted = false
                    print("Estamos gravando vc")
                }) {
                    Image(systemName: "stop.fill")
                        .padding(.leading, screenSize.width * 0.02)
                        .foregroundColor(Color.red)
                }
                
            }
            Slider(value: $sliderValue)
                .padding(.horizontal, screenSize.width * 0.02)
            Button() {
                audioRecorder.deleteRecording(urlsToDelete: recordAudioURL)
                isDeleted = true
                print("aa")
            } label: {
                Image(systemName: "trash")
                    .padding(.trailing, screenSize.width * 0.02)
                    .foregroundColor(Color.gray)
            }
        }
    }
}

struct backSideSaveView: View{
    @ObservedObject var audioRecorder: AudioRecorder = AudioRecorder()
    
    
    @State var recordAudioURL: [URL] = []
    @State private var isDeleted: Bool = false
    let screenSize: CGSize = UIScreen.main.bounds.size
    @Binding var recordAudio: CKAsset?
    @Binding var title: String
    @Binding var text: String
    @State private var sliderValue: Double = 0
    
//    var flashCard: FlashCard
    var body: some View{
        HStack {
            Text("Title")
                .padding(.leading, screenSize.width * 0.03)
            Spacer()
        }
        RoundedRectangle(cornerRadius: 5)
            .stroke(.gray, lineWidth: 1)
            .opacity(0.5)
            .frame(width: screenSize.width * 0.8, height: screenSize.height * 0.03)
            .overlay(
            TextField("Placeholder", text: $title)
                .padding(.leading, screenSize.width * 0.01)
        )
        HStack {
            Text("Image")
                .padding(.leading, screenSize.width * 0.03)
            Spacer()
        }
        Button() {
            print("aaaa")
        } label: {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: screenSize.width * 0.8, height: screenSize.height * 0.1)
                .foregroundColor(.gray)
                .opacity(0.5)
                .overlay(
                    Text("\(Image(systemName: "photo")) Add Image")
                        .foregroundColor(.black)
                )
        }
        HStack {
            Text("Long Description or Definition ")
                .padding(.leading, screenSize.width * 0.03)
            Spacer()
        }
        RoundedRectangle(cornerRadius: 5)
            .stroke(.gray, lineWidth: 1)
            .opacity(0.5)
            .frame(width: screenSize.width * 0.8, height: screenSize.height * 0.14)
            .overlay(
                VStack {
                    TextEditor(text: $text)
                        .lineLimit(nil)
                        .padding([.leading, .top], screenSize.width * 0.01)
                    Spacer()
                }
            )
        HStack {
            Text("Audio")
                .padding(.leading, screenSize.width * 0.03)
            Spacer()
        }
        HStack {
            if audioRecorder.recording == false {
                Button(action: { self.audioRecorder.startRecording() }) {
                    Image(systemName: "mic")
                        .padding(.leading, screenSize.width * 0.02)
                        .foregroundColor(Color.gray)
                }
        

            } else {
                Button(action: {
                    self.audioRecorder.stopRecording()
                    
                    guard let record = self.audioRecorder.auxRecordings?.fileURL else { return }
                    recordAudio = CKAsset.init(fileURL: record)
                    recordAudioURL.append(record)
                    isDeleted = false
                }) {
                    Image(systemName: "stop.fill")
                        .padding(.leading, screenSize.width * 0.02)
                        .foregroundColor(Color.red)
                }
                
            }
            Slider(value: $sliderValue)
                .padding(.horizontal, screenSize.width * 0.02)
            Button() {
                audioRecorder.deleteRecording(urlsToDelete: recordAudioURL)
                isDeleted = true
            } label: {
                Image(systemName: "trash")
                    .padding(.trailing, screenSize.width * 0.02)
                    .foregroundColor(Color.gray)
            }
        }
    }
}

enum Side {
    case front, back
}

