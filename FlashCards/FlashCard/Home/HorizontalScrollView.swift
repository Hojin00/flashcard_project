//
//  HorizontalScrollView.swift
//  FlashCards
//
//  Created by Willian Magnum Albeche on 28/10/21.
//

import SwiftUI

struct HorizontalScrollView: View {
    
    
    var body: some View {
        
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Container@*/VStack/*@END_MENU_TOKEN@*/ {
            ScrollView(.horizontal,showsIndicators: false) {
                HStack {
                    ForEach(0..<30) { index in
                        EmptyView()
                        Button{
                            //action
                        }label: {
                            ZStack {
                                //Image("AllDecksDeckBackground")
                                //    .padding(.top, UIScreen.main.bounds.height * 0.1)
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.red)
                                    .frame(width: UIScreen.main.bounds.width * 0.650, height: UIScreen.main.bounds.height * 0.5)
                                    .shadow(radius: 10)
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.blue)
                                    .frame(width: UIScreen.main.bounds.width * 0.685, height: UIScreen.main.bounds.height * 0.5)
                                    .padding(.bottom, UIScreen.main.bounds.height * 0.025)
                                    .shadow(radius: 10)
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.green)
                                    .frame(width: UIScreen.main.bounds.width * 0.700, height: UIScreen.main.bounds.height * 0.5)
                                    .padding(.bottom, UIScreen.main.bounds.height * 0.050)
                                    .shadow(radius: 10)
                                VStack {
                                    Text("+")
                                        .font(.title)
                                    Text("Algum deck")
                                }
                                .padding(.bottom, UIScreen.main.bounds.height * 0.030)
                                .foregroundColor(Color.black)
                            }
                        }
                    }
                }
            }
        }
    }
    
}


struct HorizontalScrollView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalScrollView()
    }
}
