//
//  MenuView.swift
//  FlashCards
//
//  Created by Lucca Molon on 10/11/21.
//

import SwiftUI
import CloudKit

struct CustomModalView: View {
    
    @EnvironmentObject private var cloudKitManager: CloudKitManager
    @EnvironmentObject private var helper: Helper
//    @State var isShowing: Bool
    @State private var isDragging = false
    @State var isPresented = false
    
    
    var card: FlashCard?
    var deck: Deck?
    
    @State private var currentHeight: CGFloat = UIScreen.main.bounds.height * 0.6
    var minHeight: CGFloat {
        if card == nil {
            return UIScreen.main.bounds.height/2 - 60
        } else {
            return UIScreen.main.bounds.height/2 - 120
        }
    }
    var maxHeight: CGFloat {
        if card == nil {
           return UIScreen.main.bounds.height * 0.6
        } else {
            return UIScreen.main.bounds.height * 0.4
        }
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            if helper.showModal {
                Color.black
                    .ignoresSafeArea()
                    .opacity(0.3)
                    .onTapGesture {
                        helper.showModal.toggle()
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
            if card == nil {
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
                            SingleDeckView(deck: deck!)
                                .scaleEffect(0.5, anchor: UnitPoint(x: UIScreen.main.bounds.width * -0.0033, y: UIScreen.main.bounds.height * 0.0009))
                                .frame(width: UIScreen.main.bounds.width * 0.2/50, height: UIScreen.main.bounds.height * 0.15/50)
                        }
                        HStack {
                            Spacer()
                            VStack(alignment: .leading, spacing: 12) {
                                Text(deck!.title != nil ? deck!.title! : "Deck title goes here if too big aaaaaaaaaaaaaa")
                                    .lineLimit(1)
                                Text("\(deck!.flashcards != nil ? String(cloudKitManager.allFlashCards.count) : "100") cards")
                                Spacer()
                            }
                            .padding(.leading, UIScreen.main.bounds.width * 0.23)
                            .padding(.trailing, UIScreen.main.bounds.width * 0.07)
                            VStack {
                                Button {
                                    helper.showModal.toggle()
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
                        NavigationLink {
                            SlideView(deck: deck!)
                        } label: {
                            customButton(text: "Practice This Deck", assetName: "square.and.pencil", corners: [.bottomLeft, .bottomRight])
                                .foregroundColor(.black)
                        }
                        NavigationLink {
                            NewCardView()
                        } label: {
                            customButton(text: "Add New Card To This Deck", assetName: "plus.square.on.square", corners: [.topLeft, .topRight])
                                .foregroundColor(.black)
                        }
                        .padding(.top, UIScreen.main.bounds.height * 0.015)
                        NavigationLink {
                            DeckView(deck: deck!)
                        } label: {
                            customButton(text: "See All Cards", assetName: "square.grid.2x2")
                                .foregroundColor(.black)
                        }
                        NavigationLink {
                            EditDeckView(deck: deck, isNewDeck: false)
                        } label: {
                            customButton(text: "Edit Deck Information", assetName: "square.and.pencil")
                                .foregroundColor(.black)
                        }
                        Button {
                            isPresented = true
                        } label: {
                            customButton(text: "Delete Deck", assetName: "trash", corners: [.bottomLeft, .bottomRight])
                                .foregroundColor(.black)
                        }
                        .alert(isPresented: $isPresented) {
                            return Alert(title: Text("Are you sure you want to delete this deck?"), primaryButton: Alert.Button.destructive(Text("Delete")) {
                                cloudKitManager.deleteDeck(deck: deck!.myrecord)
                                        }, secondaryButton: Alert.Button.default(Text("Cancel")) {
                                            print("canceled")
                                        })
                        }
                    }
                    .frame(maxHeight: .infinity)
                    .padding(.bottom, 35)
            } else {
                ZStack {
                    Capsule()
                        .frame(width: 40, height: 6)
                        .opacity(0.5)
                }
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.00001))
                .gesture(dragGesture)
                VStack {
                    ZStack {
                        CardPreview(cardType: .normalCard, flashcard: card)
                            .scaleEffect(0.38, anchor: UnitPoint(x: UIScreen.main.bounds.width * -0.0028, y: UIScreen.main.bounds.height * 0.00075))
                            .frame(width: UIScreen.main.bounds.width * 0.2/50, height: UIScreen.main.bounds.height * 0.15/50)
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text(card!.title! != nil ? card!.title! : "card title here")
                                .font(.title3)
                                .fontWeight(.bold)
                            Text("card")
                            Spacer()
                        }
                        .padding(.top, -UIScreen.main.bounds.height * 0.012)
                        .padding(.leading, UIScreen.main.bounds.width * 0.3)
                        .padding(.trailing, UIScreen.main.bounds.width * 0.2)
                        Spacer()
                        VStack {
                            Button {
                                helper.showModal.toggle()
                                
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
                            .padding(.trailing, UIScreen.main.bounds.width * 0.05)
                            Spacer()
                        }
                    }
                    Divider()
                    customButton(text: "Share This Card", assetName: "square.and.arrow.up", corners: [.topLeft, .topRight])
                        .padding(.top, UIScreen.main.bounds.height * 0.012)
                    NavigationLink {
                        EditCardView(flashcard: card)
                    } label: {
                        customButton(text: "Edit Card Information", assetName: "square.and.pencil")
                    }
                    Button {
                        isPresented = true
                    } label: {
                        customButton(text: "Delete Card", assetName: "trash", corners: [.bottomLeft, .bottomRight])
                            .foregroundColor(.black)
                    }
                    .alert(isPresented: $isPresented) {
                        return Alert(title: Text("Are you sure you want to delete this deck?"), primaryButton: Alert.Button.destructive(Text("Delete")) {
                            cloudKitManager.deleteFlashCard(flashCard: card!.myrecord)
                                    }, secondaryButton: Alert.Button.default(Text("Cancel")) {
                                        print("canceled")
                                    })
                    }
                }
                .frame(maxHeight: .infinity)
                .padding(.bottom, 40)
            }
            
            //}
        }
        .frame(height: currentHeight)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 20))
        .animation(isDragging ? nil : .easeInOut(duration: 0.45))
        .onAppear {
            if card == nil {
                CloudKitManager.shared.fetchDeck(deckID: deck!.id) { Result in
                    switch Result {
                    case .success:
                        print("sucesso")
                    case .failure:
                        print("nao deu")
                    }
                }
                currentHeight = UIScreen.main.bounds.height * 0.6
            } else {
               print("card")
                currentHeight = UIScreen.main.bounds.height * 0.4
            }
        }
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
                    helper.showModal.toggle()
                }
            }
    }
}

//struct CustomModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        //TestView()
//        CustomModalView(isShowing: .constant(true), card: FlashCard(myrecord: CKRecord.init(recordType: "card"), title: "card title", frontSideText: nil, frontSideImage: nil, backSideText: nil, backSideImage: nil, category: nil, frontSideAudio: nil, backSideAudio: nil, hard: nil))
//        //CustomModalView(isShowing: .constant(true), deck: Deck.init(record: CKRecord.init(recordType: "Deck")))
//        
//    }
//}
