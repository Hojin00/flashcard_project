//
//  HorizontalScrollView.swift
//  FlashCards
//
//  Created by Willian Magnum Albeche on 28/10/21.
//

import SwiftUI

struct HorizontalScrollView: View {
    
    let screenSize: CGSize
    let width: CGFloat
    let paddingX:CGFloat
    
    var body: some View {
        
        
        GeometryReader { reader in
            
            let midX = reader.frame(in: .global).midX
            let distance = abs(screenSize.width / 2 - midX)
            let damping: CGFloat = 4.5
            let percentage = abs(distance / (screenSize.width / 2) / damping - 1)
            
            //ScrollView(.horizontal,showsIndicators: false) {
            HStack{
                        
                            Button{
                                //action
                            }label: {
                                ZStack {
                                    //Image("AllDecksDeckBackground")
                                    //    .padding(.top, UIScreen.main.bounds.height * 0.1)
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color.red)
                                        .frame(width: UIScreen.main.bounds.width * 0.570, height: UIScreen.main.bounds.height * 0.4)
                                        .shadow(radius: 10)
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color.blue)
                                        .frame(width: UIScreen.main.bounds.width * 0.600, height: UIScreen.main.bounds.height * 0.4)
                                        .padding(.bottom, UIScreen.main.bounds.height * 0.025)
                                        .shadow(radius: 10)
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color.green)
                                        .frame(width: UIScreen.main.bounds.width * 0.620, height: UIScreen.main.bounds.height * 0.4)
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
            .scaleEffect(percentage)
            //.background(Color.yellow)
                    //.padding(.horizontal, 10.0)
                    
            //}
            //.padding(.horizontal, paddingX)
        }
        
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
