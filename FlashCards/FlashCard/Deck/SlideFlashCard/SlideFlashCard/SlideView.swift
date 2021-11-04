//
//  SlideView.swift
//  FlashCards
//
//  Created by Willian Magnum Albeche on 20/10/21.
//

import SwiftUI

struct Deck: Hashable, CustomStringConvertible {
    var id: Int
    
    let firstName: String
   let imageName: String
    var description: String {
        return "\(firstName), id: \(id)"
    }
}



struct SlideView: View {
    /// List of users EXEMPLO TROCAR DEPOIS POR FLASH CARD
    @State var users: [Deck] = [
        Deck(id: 0, firstName: "",imageName: ""),
        Deck(id: 1, firstName: "",imageName: ""),
        Deck(id: 2, firstName: "",imageName: ""),
        Deck(id: 3, firstName: "",imageName: ""),
        Deck(id: 4, firstName: "",imageName: ""),
        Deck(id: 5, firstName: "",imageName: ""),
        Deck(id: 6, firstName: "",imageName: ""),
        Deck(id: 7, firstName: "",imageName: ""),
        Deck(id: 8, firstName: "",imageName: ""),
        Deck(id: 9, firstName: "",imageName: "")
    ]
    
    /// Return the CardViews width for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(users.count - 1 - id) * 20
        return geometry.size.width - offset
    }
    
    /// Return the CardViews frame offset for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(users.count - 5 - id) * -10
    }
    
    private var maxID: Int {
        return self.users.map { $0.id }.max() ?? 0
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                LinearGradient(gradient: Gradient(colors: [Color.init(#colorLiteral(red: 0.1764705926, green: 1, blue: 0.5607843399, alpha: 1)), Color.init(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]), startPoint: .bottom, endPoint: .top)
                    .frame(width: geometry.size.width * 1.5, height: geometry.size.height)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .offset(x: -geometry.size.width / 4, y: -geometry.size.height / 2)
                    
                
                VStack(spacing: 24) {
                    //DateView()
                    ZStack {
                        ForEach(self.users, id: \.self) { user in
                            Group {
                                // Range Operator
                                if (self.maxID - 3)...self.maxID ~= user.id {
                                    CardViewSlide(user: user, onRemove: { removedUser in
                                        // Remove that user from our array
                                        self.users.removeAll { $0.id == removedUser.id }
                                    })
                                        .animation(.spring())
                                        .frame(width: self.getCardWidth(geometry, id: user.id), height: 800)
                                        .offset(x: 0, y: self.getCardOffset(geometry, id: user.id))
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
