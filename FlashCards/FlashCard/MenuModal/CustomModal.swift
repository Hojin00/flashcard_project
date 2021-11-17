//
//  MenuView.swift
//  FlashCards
//
//  Created by Lucca Molon on 10/11/21.
//

import SwiftUI
import CloudKit

struct CustomModalView: View {
    
    @Binding var isShowing: Bool
    @State private var isDragging = false
    
    var deck: Deck
    
    @State private var currentHeight: CGFloat = UIScreen.main.bounds.height * 0.6
    let minHeight: CGFloat = UIScreen.main.bounds.height/2 - 60
    let maxHeight: CGFloat = UIScreen.main.bounds.height * 0.6
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.black
                    .ignoresSafeArea()
                    .opacity(0.3)
                    .onTapGesture {
                        isShowing = false
                    }
                mainView
                .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut)
    }
    
    var mainView: some View {
        VStack {
            ZStack {
                Capsule()
                    .frame(width: 40, height: 6)
                    .opacity(0.5)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            .gesture(dragGesture)
            //ZStack {
                VStack {
                    ZStack {
                        SingleDeckView(deck: deck)
                            .scaleEffect(0.5, anchor: UnitPoint(x: UIScreen.main.bounds.width * -0.0033, y: UIScreen.main.bounds.height * 0.0009))
                            .frame(width: UIScreen.main.bounds.width * 0.2/50, height: UIScreen.main.bounds.height * 0.15/50)
                    }
                    
                    HStack {
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 12) {
                            //aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa -> 40 caracteres
                            Text(deck.title != nil ? deck.title! : "Deck title goes here if too big aaaaaaaaaaaaaa")
                                .lineLimit(1)
                                
                            Text("\(deck.flashcards != nil ? String(deck.flashcards!.count) : "100") cards")
                            Spacer()
                        }
                        .padding(.leading, UIScreen.main.bounds.width * 0.23)
                        .padding(.trailing, UIScreen.main.bounds.width * 0.07)
                        VStack {
                            Button {
                                isShowing = false
                            } label: {
                                ZStack {
                                    Circle()
                                        .frame(width: UIScreen.main.bounds.width * 0.07, height: UIScreen.main.bounds.width * 0.07)
                                        .opacity(0.3)
                                        .foregroundColor(.black)
                                        .opacity(0.3)
                                    Image(systemName: "xmark")
                                        .foregroundColor(.black)
                                        .opacity(0.7)
                                }
                            }
                            .padding(.trailing, UIScreen.main.bounds.width * 0.02)
                            Spacer()
                        }
                        Spacer()
                    }
                    
                    Divider()
                    Button {
                        print("share")
                    } label: {
                        customButton(text: "Share This Deck", assetName: "square.and.arrow.up", corners: [.topLeft, .topRight])
                            .foregroundColor(.black)
                    }
                    .padding(.top, UIScreen.main.bounds.height * 0.008)
                    Button {
                        print("practice")
                    } label: {
                        customButton(text: "Practice This Deck", assetName: "square.and.pencil", corners: [.bottomLeft, .bottomRight])
                            .foregroundColor(.black)
                    }
                    Button {
                        print("add new card")
                    } label: {
                        customButton(text: "Add New Card To This Deck", assetName: "plus.square.on.square", corners: [.topLeft, .topRight])
                            .foregroundColor(.black)
                    }
                    .padding(.top, UIScreen.main.bounds.height * 0.015)
                    Button {
                        print("see all cards")
                    } label: {
                        customButton(text: "See All Cards", assetName: "square.grid.2x2")
                            .foregroundColor(.black)
                    }
                    Button {
                        print("edit")
                    } label: {
                        customButton(text: "Edit Deck Information", assetName: "square.and.pencil")
                            .foregroundColor(.black)
                    }
                    Button {
                        print("delete")
                    } label: {
                        customButton(text: "Delete Deck", assetName: "trash", corners: [.bottomLeft, .bottomRight])
                            .foregroundColor(.black)
                    }
                    
                }
                .frame(maxHeight: .infinity)
                .padding(.bottom, 35)
            //}
        }
        .frame(height: currentHeight)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 20))
        .animation(isDragging ? nil : .easeInOut(duration: 0.45))
    }
    
    @State private var prevDragTranslation = CGSize.zero
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { val in
                if !isDragging {
                    isDragging = true
                }
                let dragAmount = val.translation.height - prevDragTranslation.height
                if currentHeight > maxHeight || currentHeight < minHeight {
                    currentHeight -= dragAmount/8
                } else {
                    currentHeight -= dragAmount
                }
                prevDragTranslation = val.translation
            }
            .onEnded { val in
                prevDragTranslation = .zero
                isDragging = false
                if currentHeight > maxHeight {
                    currentHeight = maxHeight
                } else if currentHeight < maxHeight && currentHeight > minHeight {
                    currentHeight = maxHeight
                } else if currentHeight < minHeight {
                    currentHeight = maxHeight
                    isShowing = false
                }
            }
    }
}


struct Menu: View {
    var body: some View {
        ZStack {
            Color.blue
            VStack {
                Text("aaa")
            }
        }
    }
}





struct CustomModalView_Previews: PreviewProvider {
    static var previews: some View {
        //TestView()
        CustomModalView(isShowing: .constant(true), deck: Deck.init(record: CKRecord.init(recordType: "Deck")))
    }
}
