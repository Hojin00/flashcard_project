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
    
    @State var selectedTheme: Int = 0
    var themeColor: Color {
        switch selectedTheme {
        case 0:
            return Color("greenColor")
            
        case 1:
            return Color("blueColor")
            
        case 2:
            return Color("redColor")
            
        case 3:
            return Color("yellowColor")
            
        default:
            return Color("greenColor")
        }
    }
    var lightThemeColor: Color {
        switch selectedTheme {
        case 0:
            return Color("lightGreenColor")
            
        case 1:
            return Color("lightBlueColor")
            
        case 2:
            return Color("lightRedColor")
            
        case 3:
            return Color("lightYellowColor")
            
        default:
            return Color("lightGreenColor")
        }
    }
    
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
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(lightThemeColor)
                            .frame(width: UIScreen.main.bounds.width * 0.500, height: UIScreen.main.bounds.height * 0.4)
                            .shadow(radius: 15)
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(lightThemeColor)
                            .frame(width: UIScreen.main.bounds.width * 0.530, height: UIScreen.main.bounds.height * 0.4)
                            .padding(.bottom, UIScreen.main.bounds.height * 0.025)
                            .shadow(radius: 15)
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width * 0.550, height: UIScreen.main.bounds.height * 0.4)
                            .padding(.bottom, UIScreen.main.bounds.height * 0.050)
                            .shadow(radius: 15)
                        VStack {
                            Rectangle()
                                .frame(width: UIScreen.main.bounds.width * 0.56, height: UIScreen.main.bounds.height * 0.03)
                                .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 50))
                                .foregroundColor(themeColor)
//                                .padding(.top, UIScreen.main.bounds.height * 0.01)
                            Spacer()
                        }
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
                        .padding(.bottom, UIScreen.main.bounds.height * 0.020)
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
                .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.height * 0.30)
            }
            .scaleEffect(percentage)
        }
        .frame(width: width)
        .frame(maxHeight: .infinity)
    }
}

struct HorizontalScrollView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
