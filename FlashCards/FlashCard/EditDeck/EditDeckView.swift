//
//  EditDeckView.swift
//  FlashCards
//
//  Created by João Brentano on 03/11/21.
//

import SwiftUI

struct EditDeckView: View {
    
    @State var text: String = ""
    @State var isAlarmOn: Bool = true
    
    var body: some View {
        ZStack {
            Circle()
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.size.width * 1.4, height: UIScreen.main.bounds.size.width * 1.4)
                .padding(.top, UIScreen.main.bounds.size.width * -1.3)
                .foregroundColor(.gray)
                .opacity(0.5)
            VStack {
                HStack {
                    Text("Edit Deck")
                        .font(.title).bold()
                    Spacer()
                    Button {
                        //to do
                    } label: {
                        Text("Cancel")
                    }
                    
                }
                .padding(.horizontal, UIScreen.main.bounds.width * 0.27)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.white)
                            .shadow(radius: 10)
                            .frame(width: UIScreen.main.bounds.width * 0.77, height: UIScreen.main.bounds.height * 0.67)
                            .padding(.top, UIScreen.main.bounds.height * 0.070)
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.white)
                            .shadow(radius: 10)
                            .frame(width: UIScreen.main.bounds.width * 0.87, height: UIScreen.main.bounds.height * 0.67)
                            .padding(.top, UIScreen.main.bounds.height * 0.035)
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.white)
                            .shadow(radius: 10)
                            .frame(width: UIScreen.main.bounds.width * 0.92, height: UIScreen.main.bounds.height * 0.67)
                        VStack {
                            HStack {
                                Text("Title of the deck")
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            .padding([.top, .leading, .trailing])
                            HStack {
                                TextField("Placeholder", text: $text)
                                    .textFieldStyle(.roundedBorder)
                                    .lineLimit(1)
                            }
                            .padding([.horizontal, .bottom])
                            HStack {
                                Text("Priority")
                                    .fontWeight(.bold)
                                    .padding(.bottom, UIScreen.main.bounds.height * 0.04)
                                PriorityButtonList()
                            }
                            Divider()
                                .padding()
                            Toggle(isOn: $isAlarmOn) {
                                Text("Alarm")
                                    .fontWeight(.bold)
                            }
                            .padding()
                            HStack {
                                Text("Alarm date and time")
                                    .fontWeight(.bold)
                                Spacer()
                                Text("???")
                            }
                            .padding()
                            HStack {
                                Text("Repeat every")
                                    .fontWeight(.bold)
                                Spacer()
                                Text("???")
                            }
                            .padding()
                            HStack {
                                Text("End repeat")
                                    .fontWeight(.bold)
                                Spacer()
                                Text("???")
                            }
                            .padding()
                            Divider()
                            HStack {
                                Text("Theme color")
                                    .fontWeight(.bold)
                                Spacer()
                                Text("???")
                            }
                            .padding()
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.92, height: UIScreen.main.bounds.height * 0.67)
                    }
                Spacer()
                Button {
                    // todo
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .foregroundColor(Color.gray)
                            .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.06)
                        Text("Done")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                }
            }
        }
    }
}

struct EditDeckView_Previews: PreviewProvider {
    static var previews: some View {
        EditDeckView()
    }
}
