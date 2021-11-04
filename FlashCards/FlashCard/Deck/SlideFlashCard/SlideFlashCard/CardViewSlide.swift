//
//  CardView.swift
//  FlashCards
//
//  Created by Willian Magnum Albeche on 20/10/21.
//

import SwiftUI

struct CardViewSlide: View {
    @State private var translation: CGSize = .zero
    @State private var swipeStatus: EasyHard = .none
    
    private var card: FlashCardMock
    private var onRemove: (_ user: FlashCardMock) -> Void
    

    
    private var thresholdPercentage: CGFloat = 0.20 // when the user has draged 35% the width of the screen in either direction
    
    private enum EasyHard: Int {
        case easy, hard, none
    }
    
    init(card: FlashCardMock, onRemove: @escaping (_ card: FlashCardMock) -> Void) {
        self.card = card
        self.onRemove = onRemove
        
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
                                    Text("12/40")
                                        .font(.caption)
                                    
                                Spacer()
                                    Text("High")
                                        .font(.caption)
            
                                }
                                .padding([.leading, .bottom, .trailing])
                                VStack(alignment: .center) {
                                    Text("\(self.card.frontSideText ?? "") PUDIM")
                                        .font(.title)
                                        .bold()
            //                        Text(self.user.occupation)
            //                            .font(.subheadline)
            //                            .bold()
            //                        Text("\(self.user.mutualFriends) Mutual Friends")
            //                            .font(.subheadline)
            //                            .foregroundColor(.gray)
                                }
                            VStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.red)
                                    .frame(width: 200, height: 200)
                            }
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
        CardViewSlide(card: FlashCardMock(id: 01, frontSideText: "", frontSideImage: "", backSideText: "", backSideImage: "", category: "", frontSideAudio: "", backSideAudio: "", frontSideColor: "", backSideColor: ""),
                 onRemove: { _ in
                    // do nothing
            })
            .frame(height: 400)
            .padding()
    }
}
