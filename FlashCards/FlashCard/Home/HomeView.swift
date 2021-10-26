//
//  HomeView.swift
//  FlashCards
//
//  Created by Willian Magnum Albeche on 26/10/21.
//

import SwiftUI

struct HomeView: View {
    
    @State var sortKey = 0
    
    var options = ["Last Seen", "Hardest","Alphabet","Biggest"]
    var body: some View {
        
        VStack{
            HStack{
                Text("Your FlashCards Decks")
                    .font(.title)
                    .bold()
                    .padding(.leading)
                Spacer()
            }
            
            HStack {
                Text("Sort by: ")
                Picker("Sort by", selection: $sortKey) {
                    ForEach(0..<options.count) {
                        Text(self.options[$0])
                            .foregroundColor(.black)
                    }
                    
                }
                .padding(.horizontal, 3)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.012, brightness: 0.869)/*@END_MENU_TOKEN@*/)
                .foregroundColor(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                .font(.headline)
                .cornerRadius(5)
                .pickerStyle(MenuPickerStyle())
                
                Spacer()
                Button("See all"){
                    print("Print tudo")
                }
                .padding(.trailing)
            }
            .padding(.leading)
            
            HStack(){
                VStack(){
                    
                    Button {
                        print("Image tapped!")
                    } label: {
                        Image("buttonNewCard")
                    }
                    
                    Button {
                        print("new deck")
                    } label : {
                        Image("buttonNewDeck")
                    }
                }
            }
            
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
