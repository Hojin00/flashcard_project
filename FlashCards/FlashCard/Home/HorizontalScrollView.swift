//
//  HorizontalScrollView.swift
//  FlashCards
//
//  Created by Willian Magnum Albeche on 28/10/21.
//

import SwiftUI

struct HorizontalScrollView: View {
    
    @EnvironmentObject private var cloudkitManager: CloudKitManager
    let deck: Deck
    let screenSize: CGSize
    let width: CGFloat
    let paddingX:CGFloat
    var topCardColor: Color = Color.white
    var middleCardColor: Color = Color.white
    var bottomCardColor: Color = Color.white
    
    var body: some View {
            GeometryReader { reader in
            
            let midX = reader.frame(in: .global).midX
            let distance = abs(screenSize.width / 2 - midX)
            let damping: CGFloat = 4.5
            let percentage = abs(distance / (screenSize.width / 2) / damping - 1)
            
            //ScrollView(.horizontal,showsIndicators: false) {
            ZStack{
                NavigationLink(destination: DeckView(deck: deck)) {
                    ZStack {
                        //Image("AllDecksDeckBackground")
                        //    .padding(.top, UIScreen.main.bounds.height * 0.1)
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(bottomCardColor)
                            .frame(width: UIScreen.main.bounds.width * 0.570, height: UIScreen.main.bounds.height * 0.4)
                            .shadow(radius: 15)
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(middleCardColor)
                            .frame(width: UIScreen.main.bounds.width * 0.600, height: UIScreen.main.bounds.height * 0.4)
                            .padding(.bottom, UIScreen.main.bounds.height * 0.025)
                            .shadow(radius: 15)
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(topCardColor)
                            .frame(width: UIScreen.main.bounds.width * 0.620, height: UIScreen.main.bounds.height * 0.4)
                            .padding(.bottom, UIScreen.main.bounds.height * 0.050)
                            .shadow(radius: 15)
                        VStack {
                            Spacer()
                            HStack {
                                Text("!!!")
                                    .bold()
                                    .padding(.leading, UIScreen.main.bounds.size.width * 0.08)
                                Spacer()
                                Image(systemName: "alarm")
                                    .padding(.trailing, UIScreen.main.bounds.size.width * 0.08)
                            }
                            Spacer()
                                .font(.title)
                            Text("\(deck.title ?? "No title")")
                                .font(.title)
                            Spacer()
                            Text("Remembered")
                                .font(.caption)
                            Text("77% easily")
                                .font(.title3)
                            Spacer()
                            HStack {
                                Spacer()
                                if let flashcardsNum = deck.flashcards {
                                    Text("\(flashcardsNum.count)\ncards")
                                        .font(.caption)
                                        .padding(.trailing, UIScreen.main.bounds.size.width * 0.07)
                                }
                            }
                            Spacer()
                        }
                        .padding(.bottom, UIScreen.main.bounds.height * 0.030)
                        .foregroundColor(Color.black)
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            print("...")
                        } label: {
                            StandardButton()
                        }
                        Spacer()
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.55, height: UIScreen.main.bounds.height * 0.30)
            }
            .scaleEffect(percentage)
        }
        //        .onAppear() {
        //
        //            CloudKitManager.shared.fetchDeckSortBy(sortType: SortBy.importanceAlphabet) { Result in
        //
        //                switch Result {
        //                case .success:
        //                    print("success importance")
        //                case .failure:
        //                    print("no last seen")
        //                }
        //            }
        //
        //        }
        .frame(width: width)
        .frame(maxHeight: .infinity)
        //.background(Color.yellow)
        
    }
    
    
}


struct HorizontalScrollView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
