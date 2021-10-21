//
//  RecordingsListView.swift
//  FlashCards
//
//  Created by Hojin Ryu on 20/10/21.
//

import Foundation
import SwiftUI
import AVFoundation

struct RecordingsListView: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        List {
            ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                RecordingRow(audioURL: recording.fileURL)
            }
            .onDelete(perform: delete)
        }
    }
    
    func delete(at offsets: IndexSet) {
        
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
        }
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
    }
}

struct RecordingRow: View {
    
    var audioURL: URL
    @State var playURL: URL?
    @ObservedObject var audioPlayer = AudioPlayer()
    
    var body: some View {
        HStack {
            Text("\(audioURL.lastPathComponent)")
            Spacer()
            if audioPlayer.isPlaying == false {
                Button(action: {
                    CloudKitManager.shared.fetchAllFlashCards { Result in
                        switch Result {
                        case .success(let flashcards):
                            playURL = flashcards[0].frontSideAudio?.fileURL
                            print(playURL)
                        default:
                            print("no decks")
                        }
                    }
                    guard let playingURL = playURL else { return }
                    self.audioPlayer.startPlayback(audio: playingURL)
                }) {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                }
            } else {
                Button(action: {
                    self.audioPlayer.stopPlayback()
                }) {
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                }
            }
        }
    }
}

struct RecordingsListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingsListView(audioRecorder: AudioRecorder())
    }
}
