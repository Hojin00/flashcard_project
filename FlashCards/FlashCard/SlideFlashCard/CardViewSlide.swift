//
//  CardView.swift
//  FlashCards
//
//  Created by Willian Magnum Albeche on 20/10/21.
//

import SwiftUI
import CloudKit
struct CardViewSlide: View {
    @State private var translation: CGSize = .zero
    @State private var swipeStatus: EasyHard = .none
    
    private var card: FlashCard
    private var onRemove: (FlashCard) -> Void
    
    var currentCard: Int
    var totalCard: Int
    
    private var thresholdPercentage: CGFloat = 0.20 // when the user has draged 35% the width of the screen in either direction
    
    private enum EasyHard: Int {
        case easy, hard, none
    }
    
    init(card: FlashCard,totalCard: Int, currentCard: Int , onRemove: @escaping (FlashCard) -> Void) {
        self.card = card
        self.onRemove = onRemove
        self.totalCard = totalCard
        self.currentCard = currentCard
        
    }
    
    /// What percentage of our own width have we swipped
    /// - Parameters:
    ///   - geometry: The geometry
    ///   - gesture: The current gesture translation value
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    

    
    var body: some View {

         GeometryReader { geometry in
            VStack {
                ZStack(alignment: self.swipeStatus == .easy ? .topLeading : .topTrailing) {
                    
                    
                    //                     Image(self.card.frontSideImage ?? "")
                    //                        .resizable()
                    //                        .aspectRatio(contentMode: .fill)
                    //                        .frame(width: geometry.size.width, height: geometry.size.height * 0.75)
                    //                        .clipped()
                    VStack {
                        HStack{
                            Text("\(currentCard)/\(totalCard)")
                                .font(.caption)

                            Spacer()
                            Text("High")
                                .font(.caption)

                        }
                        .padding([.leading, .bottom, .trailing])
                        VStack(alignment: .center) {
                            Text(card.title ?? "Pudim")
                                .font(.title)
                                .bold()
                                .foregroundColor(.gray)
                        }
                        VStack{
                            Image("OPudim")
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(10)
                                .frame(width: 200, height: 200)
                        }
                        VStack{
                            Text(card.frontSideText ?? "um pudim feliz")
                        }

                        HStack{

                            Button(){

                            }label: {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 100, height: 40)
                                    .foregroundColor(Color(hue: 0.293, saturation: 0.792, brightness: 0.891))
                            }
//                            Circle()
//                                .foregroundColor(Color.red)
//
//                                .frame(width: 130, height: 130)
//                                .background(Color.blue)
//                                .clipShape(Circle())
//                                .offset(x: -170, y: 60)
//
//                            Circle()
//                                .foregroundColor(Color.green)
//                                .frame(width: 130, height: 130)
//                                .background(Color.blue)
//                                .clipShape(Circle())
//                                .offset(x: 170, y: 60)
                        }
//                        LinearGradient(gradient: Gradient(colors: [Color.init(#colorLiteral(red: 0.1764705926, green: 1, blue: 0.5607843399, alpha: 1)), Color.init(#colorLiteral(red: 0.9601020217, green: 0.9646142125, blue: 0.9777105451, alpha: 0))]), startPoint: .bottom, endPoint: .top)
                    }
                    if self.swipeStatus == .easy {
                        Text("EASY")
                            .font(.headline)

                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .foregroundColor(Color.white)

                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.green, lineWidth: 3.0)
                            ).padding(24)
                            .rotationEffect(Angle.degrees(-45))
                    } else if self.swipeStatus == .hard {
                        Text("HARD")
                            .font(.headline)

                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                            .foregroundColor(Color.white)

                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.red, lineWidth: 3.0)
                            ).padding(.top, 45)
                            .rotationEffect(Angle.degrees(45))
                    }

                    
                }
                     
                
            }
            .padding(.bottom)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .animation(.interactiveSpring())
           .offset(x: self.translation.width, y: 0)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.translation = value.translation
                        
                        if (self.getGesturePercentage(geometry, from: value)) >= self.thresholdPercentage {
                            self.swipeStatus = .easy
                        } else if self.getGesturePercentage(geometry, from: value) <= -self.thresholdPercentage {
                            self.swipeStatus = .hard
                        } else {
                            self.swipeStatus = .none
                        }
                        
                    }.onEnded { value in
                        // determine snap distance > 0.5 aka half the width of the screen
                        if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPercentage {
                            self.onRemove(self.card)
                        } else {
                            self.translation = .zero
                        }
                    }
            )
            
            
        }
    }
}

// 7
struct CardViewSlide_Previews: PreviewProvider {
    static var previews: some View {
        CardViewSlide(card: FlashCard.init(record: CKRecord(recordType: "")), totalCard: 0, currentCard: 0, onRemove: { _ in})
            .frame(height: 400)
            .padding()
    }
}
