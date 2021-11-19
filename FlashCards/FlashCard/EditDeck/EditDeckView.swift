//
//  EditDeckView.swift
//  FlashCards
//
//  Created by João Brentano on 03/11/21.
//

import SwiftUI
import CloudKit

struct EditDeckView: View {
    
    @State var text: String = ""
    @State var isAlarmOn: Bool = true
    @State var date1 = Date()
    @State var date2 = Date()
    @State var selectedPriority: Int = 0
    @State var selectedDays: [Bool] = [false, false, false, false, false, false, false]
    @State var selectedTheme: Int = 0
    let isNewDeck: Bool
    var deck: Deck
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
    
    init(deck: Deck?, isNewDeck: Bool) {
        self.isNewDeck = isNewDeck
        if let deck = deck {
            self.deck = deck
            self.text = deck.title ?? "No title"
            if let reminderDate = deck.reminderDate {
                self.date1 = reminderDate
                self.isAlarmOn = true
            } else {
                self.isAlarmOn = false
            }
//            self.selectedPriority = deck.priority
//            self.selectedDays = deck.selectedDays
//            self.selectedTheme = deck.theme
        } else {
            self.deck = Deck(record: CKRecord.init(recordType: "Deck"))
        }
    }
    
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
                            .border(themeColor)
                        VStack {
                            Rectangle()
                                .frame(width: UIScreen.main.bounds.width * 0.92, height: UIScreen.main.bounds.height * 0.025)
                                .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 50))
                                .foregroundColor(themeColor)
                                .padding(.top, UIScreen.main.bounds.height * 0.03)
                            Spacer()
                        }
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
                                PriorityPickerView(selectedPriority: $selectedPriority)
                            }
                            Divider()
                                .padding()
                            Toggle(isOn: $isAlarmOn) {
                                Text("Alarm")
                                    .fontWeight(.bold)
                            }
                            .padding(.horizontal)
                            HStack {
                                VStack {
                                    Text("Alarm date")
                                        .fontWeight(.bold)
                                    HStack {
                                        Text(" and time")
                                            .fontWeight(.bold)
                                        Spacer()
                                    }
                                }
                                Spacer()
                                DatePicker("", selection: $date1)
                            }
                            .padding()
                            HStack {
                                Text("Repeat")
                                    .fontWeight(.bold)
                                    .padding(.leading)
//                                Spacer()
                                WeekdayPickerView(selectedDays: $selectedDays)
                            }
                            .padding()
                            HStack {
                                Text("End repeat")
                                    .fontWeight(.bold)
                                    .padding(.trailing, UIScreen.main.bounds.width * 0.01)
                                Spacer()
                                DatePicker("", selection: $date2)
                            }
                            .padding()
                            Divider()
                            HStack {
                                Text("Theme color")
                                    .fontWeight(.bold)
                                Spacer()
                                ThemePickerView(selectedTheme: $selectedTheme)
                            }
                            .padding()
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.92, height: UIScreen.main.bounds.height * 0.67)
                    }
                Spacer()
                Button {
                    if isNewDeck {
                        
                    } else {
                        
                    }
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
                .offset(x: 0, y: 15)
            }
        }
    }
}

struct EditDeckView_Previews: PreviewProvider {
    static var previews: some View {
        EditDeckView(deck: nil, isNewDeck: true)
    }
}
