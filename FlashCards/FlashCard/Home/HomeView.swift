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
                            ZStack {
                                Image("buttonNewCard")
                                HStack {
                                    Image(systemName:"plus")
                                        .resizable()
                                        .foregroundColor(Color.black)
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                    
                                    Text("New \n Card")
                                        .font(.system(size: 16.0))
                                        .fontWeight(.bold)
                                        .lineLimit(2)
                                        .foregroundColor(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                                }
                            }
                            
                        }
                        
                        Button {
                            print("new deck")
                        } label : {
                            ZStack {
                                Image("buttonNewDeck")
                                HStack(alignment: .center, spacing: 0.0) {
                                    Text("New \n Deck")
                                        .font(.system(size: 16.0))
                                        .fontWeight(.bold)
                                        .lineLimit(2)
                                        .foregroundColor(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                                    
                                    Image(systemName:"plus")
                                        .resizable()
                                        .foregroundColor(Color.black)
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                    
                                }
                                .offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y:  -10)
                            }
                        }
                    }
                }
                
                Divider()
            }
            
            VStack{
                Text("Carrosel")
            }
        }
        
        
        
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
