//
//  EditCardSideView.swift
//  FlashCards
//
//  Created by Lucca Molon on 05/11/21.
//

import SwiftUI

struct EditCardSideView: View {
    
    let screenSize: CGSize = UIScreen.main.bounds.size
    @State private var title: String = ""
    @State private var text: String = ""
    @State private var sliderValue: Double = 0
    var side: Side
    var flashcard: FlashCard?
    
    var body: some View {
        VStack {
            if side == .front {
                Text("Front Side")
            } else {
                Text("Back Side")
            }
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
            if flashcard?.frontSideImage != nil && side == .front {
                RoundedRectangle(cornerRadius: 5)                    // alterar roundedRectangle por Image
                    .frame(width: screenSize.width * 0.8, height: screenSize.height * 0.1)
                    .foregroundColor(.gray)
                    .opacity(0.5)
            } else if flashcard?.backSideImage != nil && side == .back {
                RoundedRectangle(cornerRadius: 5)                     // alterar roundedRectangle por Image
                    .frame(width: screenSize.width * 0.8, height: screenSize.height * 0.1)
                    .foregroundColor(.gray)
                    .opacity(0.5)
            } else {
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
            }
            HStack {
                Text("Description or Question")
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
                    Button {
                        print("a")
                    } label: {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: screenSize.width * 0.09, height: screenSize.width * 0.09)
                            .foregroundColor(.gray)
                            .opacity(0.5)
                            .overlay(
                                Image(systemName: "mic")
                                    .foregroundColor(.black)
                            )
                    }
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: screenSize.width * 0.68, height: screenSize.width * 0.09)
                        .foregroundColor(.gray)
                        .opacity(0.5)
                    HStack {
                        Button() {
                            print("play")
                        } label: {
                            Image(systemName: "play")
                                .resizable()
                                .frame(width: screenSize.width * 0.05, height: screenSize.width * 0.05)
                                .foregroundColor(.black)
                        }
                        HStack {
                            Slider(value: $sliderValue)
                                .frame(width: screenSize.width * 0.45, height: screenSize.width * 0.09)
                            Text("00:03")
                                .font(.caption)
                        }
                        .frame(width: screenSize.width * 0.57, height: screenSize.height * 0.02)
                    }
                }
                    Button() {
                        print("aa")
                    } label: {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: screenSize.width * 0.09, height: screenSize.width * 0.09)
                            .foregroundColor(.gray)
                            .opacity(0.5)
                            .overlay(
                                Image(systemName: "trash")
                                    .foregroundColor(.black)
                            )
                            //.padding(.trailing, screenSize.width * 0.02)
                }
                
            }
            .padding(.horizontal, screenSize.width * 0.02)
        }
        .onAppear {
            guard let flashcard = flashcard else {
                return
            }
            if flashcard.title != nil {
                title = flashcard.title!
            }
            if flashcard.frontSideText != nil && side == .front {
                text = flashcard.frontSideText!
            }
            if flashcard.backSideText != nil && side == .back {
                text = flashcard.backSideText!
            }
            
        }
        //.background(color)
    }
       
            
}



struct EditCardSideView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardSideView(side: .front)
    }
}
