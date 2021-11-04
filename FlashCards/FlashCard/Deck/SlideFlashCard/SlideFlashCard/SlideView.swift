//
//  SlideView.swift
//  FlashCards
//
//  Created by Willian Magnum Albeche on 20/10/21.
//

import SwiftUI

struct FlashCardMock: Hashable  {
    //var description: String
    
    var id: Int
    
    var frontSideText: String?
    var frontSideImage: String?
    var backSideText: String?
    var backSideImage: String?
    var category: String?
    var frontSideAudio: String?
    var backSideAudio: String?
    var frontSideColor: String?
    var backSideColor: String?
    
}

struct SlideView: View {
    /// List of users EXEMPLO TROCAR DEPOIS POR FLASH CARD
    @State var cards: [FlashCardMock] = [
        FlashCardMock(id: 01, frontSideText: "", frontSideImage: "", backSideText: "", backSideImage: "", category: "", frontSideAudio: "", backSideAudio: "", frontSideColor: "", backSideColor: ""), FlashCardMock(id: 02, frontSideText: "", frontSideImage: "", backSideText: "", backSideImage: "", category: "", frontSideAudio: "", backSideAudio: "", frontSideColor: "", backSideColor: ""), FlashCardMock(id: 03, frontSideText: "", frontSideImage: "", backSideText: "", backSideImage: "", category: "", frontSideAudio: "", backSideAudio: "", frontSideColor: "", backSideColor: ""), FlashCardMock(id: 04, frontSideText: "", frontSideImage: "", backSideText: "", backSideImage: "", category: "", frontSideAudio: "", backSideAudio: "", frontSideColor: "", backSideColor: ""),
    
    ]
    
    /// Return the CardViews width for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(cards.count - 1 - id)
        return geometry.size.width - offset
    }
    private func getCardHeight(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(cards.count - 1 - id)
        return geometry.size.height - offset
    }
    
    /// Return the CardViews frame offset for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(cards.count - 5 - id) * -10
    }
    
    private var maxID: Int {
        return self.cards.map { $0.id }.max() ?? 0
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                LinearGradient(gradient: Gradient(colors: [Color.init(#colorLiteral(red: 0.1764705926, green: 1, blue: 0.5607843399, alpha: 1)), Color.init(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]), startPoint: .bottom, endPoint: .top)
                    .frame(width: geometry.size.width * 1.5, height: geometry.size.height)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .offset(x: -geometry.size.width / 4, y: -geometry.size.height / 2)
                    
                
                VStack(alignment: .center, spacing: 0.0) {
                    //DateView()
                    ZStack {
                        ForEach(self.cards, id: \.self) { card in
                            Group {
                                // Range Operator
                                if (self.maxID - 3)...self.maxID ~= card.id {
                                    CardViewSlide(card: card, onRemove: { removedUser in
                                        // Remove that user from our array
                                        self.cards.removeAll { $0.id == removedUser.id }
                                    })
                                        .animation(.spring())
                                        .frame(width: self.getCardWidth(geometry, id: card.id), height: 500)
                                        .offset(x: 0, y: self.getCardOffset(geometry, id: card.id))
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
        }.padding()
    }
}

//struct DateView: View {
//    var body: some View {
//        VStack {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text("Friday, 10th January")
//                        .font(.title)
//                        .bold()
//                    Text("Today")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                }
//                Spacer()
//            }.padding()
//        }
//        .background(Color.white)
//        .cornerRadius(10)
//        .shadow(radius: 5)
//    }
//}

//struct Triangle: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
//
//        return path
//    }
//}

struct SlideView_Previews: PreviewProvider {
    static var previews: some View {
    SlideView()
    }
}
