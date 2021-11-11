//
//  HomeView.swift
//  FlashCards
//
//  Created by Willian Magnum Albeche on 26/10/21.
//

import SwiftUI
import AVFoundation

struct HomeView: View {
    @EnvironmentObject private var cloudkitManager: CloudKitManager
    
    @State private var offset = CGFloat.zero
    @State private var scrollOffset: CGFloat = 0
    @State var selection = 0
    @State var sortKey = 0
    
    var options = ["None", "Alphabet", "Biggest", "Hardest", "Importance", "Last Seen", "Last Updated" ]
    let dispatchSemaphore: DispatchSemaphore = DispatchSemaphore(value: 1)
    
    
    var body: some View {
        
        GeometryReader { geometry in
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .bottom, endPoint: .top)
                .frame(width: geometry.size.width * 1.5, height: geometry.size.height)
                .background(Color.blue)
                .clipShape(Circle())
                .offset(x: -geometry.size.width / 4, y: -geometry.size.height / 3)
            
            VStack {
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
                        .onChange(of: sortKey, perform: { newValue in
                            
                            
                            switch sortKey {
                            case 1:
                                CloudKitManager.shared.fetchDeckSortBy(sortType: SortBy.alphabet) { Result in
                                    switch Result {
                                    case .success:
                                        print("success alphabet")
                                        
                                    case .failure:
                                        print("no last seen")
                                        
                                    }
                                }
                                
                            case 2:
                                
                                CloudKitManager.shared.fetchDeckSortBy(sortType: SortBy.hadest) { Result in
                                    switch Result {
                                    case .success:
                                        print("success biggest")
                                        
                                    case .failure:
                                        print("no last seen")
                                        
                                    }
                                }

                            case 3:
                                
                                CloudKitManager.shared.fetchDeckSortBy(sortType: SortBy.hardest) { Result in
                                    
                                    switch Result {
                                    case .success:
                                        print("success hardest")
                                        
                                    case .failure:
                                        print("no last seen")
                                        
                                    }
                                }
                                
                            case 4:
                                
                                CloudKitManager.shared.fetchDeckSortBy(sortType: SortBy.importanceAlphabet) { Result in
                                    
                                    switch Result {
                                    case .success:
                                        print("success importanceAlphabet")
                                        
                                    case .failure:
                                        print("no last seen")
                                        
                                    }
                                }
                                
                            case 5:
                                
                                CloudKitManager.shared.fetchDeckSortBy(sortType: SortBy.lastSeen) { Result in
                                    
                                    switch Result {
                                    case .success:
                                        print("success last seen")
                                        
                                    case .failure:
                                        print("no last seen")
                                        
                                    }
                                }
                                
                            case 6:
                                
                                CloudKitManager.shared.fetchDeckSortBy(sortType: SortBy.lastUpdated) { Result in
                                    
                                    switch Result {
                                    case .success:
                                        print("success last updated")
                                        
                                    case .failure:
                                        print("no last seen")
                                        
                                    }
                                }
                                
                            default:
                                print("no sortTypes")
                            }
                        })
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
                    ScrollView(.horizontal) {
                        HStack(alignment: .center){
                            VStack(){
                                Button {
                                    print("new card")
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
                                            .frame(width: 23, height: 24)

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
                                .padding(UIScreen.main.bounds.size.height * 0.038)

                            }

                            HStack(){

                                ForEach(cloudkitManager.allDecks){ i in
                                    EmptyView()
                                    
                                    if cloudkitManager.allDecks.last == i {
                                        SingleDeckView(deck: i)
                                        .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.25)
                                        .onAppear {
                                            print("igual")
                                            
                                            //chegou antes
                                            
                                            dispatchSemaphore.wait()
                                            print("wait2")
                                            cloudkitManager.fetchNextDeckSortBy(sortType: SortBy.lastSeen) { Result in
                                                switch Result {
                                                case .success(_):
                                                    print("count:",cloudkitManager.allDecks.count)
                                                    print("success")
                                                    
                                                case .failure:
                                                    print("fail")
                                                    
                                                }
                                                dispatchSemaphore.signal()
                                            }
                                        }
                                    }
                                    else {
                                        SingleDeckView(deck: i)
                                        .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.25)
                                    }
                                }
                            }
                        }
                        .background(GeometryReader {
                            Color.clear.preference(key: ViewOffsetKey.self,
                                                   value: -$0.frame(in: .named("scroll")).origin.x)
                        })
//                        .onPreferenceChange(ViewOffsetKey.self) {
//                            print("offset >> \($0)")
////                            if ($0 / CGFloat(cloudkitManager.allDecks.count)) > 10 {
////                                cloudkitManager.fetchNextDeckSortBy(sortType: SortBy.lastSeen) { Result in
////                                    switch Result {
////                                    case .success(_):
////                                        print("success")
////
////                                    case .failure:
////                                        print("fail")
////                                    }
////                                }
////                            }
//                        }
                    }.coordinateSpace(name: "scroll")
                    
                    
//                    TabView(selection: $selection) {
//                        HStack(alignment: .center){
//
//                            VStack(){
//                                Button {
//                                    print("new card")
//                                } label: {
//                                    ZStack {
//                                        Image("buttonNewCard")
//                                        HStack {
//                                            Image(systemName:"plus")
//                                                .resizable()
//                                                .foregroundColor(Color.black)
//                                                .scaledToFit()
//                                                .frame(width: 25, height: 25)
//
//                                            Text("New \n Card")
//                                                .font(.system(size: 16.0))
//                                                .fontWeight(.bold)
//                                                .lineLimit(2)
//                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
//                                        }
//                                    }
//                                }
//
//                                Button {
//                                    print("new deck")
//                                } label : {
//                                    ZStack {
//                                        Image("buttonNewDeck")
//                                            .frame(width: 23, height: 24)
//
//                                        HStack(alignment: .center, spacing: 0.0) {
//                                            Text("New \n Deck")
//                                                .font(.system(size: 16.0))
//                                                .fontWeight(.bold)
//                                                .lineLimit(2)
//                                                .foregroundColor(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
//
//                                            Image(systemName:"plus")
//                                                .resizable()
//                                                .foregroundColor(Color.black)
//                                                .scaledToFit()
//                                                .frame(width: 25, height: 25)
//
//                                        }
//                                        .offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y:  -10)
//                                    }
//
//                                }
//                                .padding(UIScreen.main.bounds.size.height * 0.038)
//
//                            }
//
//                            HStack(){
//
//                                ForEach(cloudkitManager.allDecks){ i in
//                                    EmptyView()
//                                    SingleDeckView(deck: i)
//                                    .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.25)
//                                }
//                            }
//                        }
//                    }
//                    .tabViewStyle(PageTabViewStyle())
                }
                Divider()
                    .frame(height: 10)
                VStack{
                    GeometryReader{ reader in
                        deckCarousel(reader: reader)
                    }
                    .frame( maxWidth: .infinity,  maxHeight: .infinity)
                    
                }
            }
        }
        .onAppear() {
            
            
//            cloudkitManager.fetchDeckSortBy(sortType: SortBy.none) { Result in
//                switch Result {
//                case .success(_):
//                    print("suc")
//
//                case .failure:
//                    print("fail")
//                }
//            }
            
            dispatchSemaphore.wait()
            print("wait")
            CloudKitManager.shared.fetchDeckSortBy(sortType: SortBy.lastSeen) { Result in
                
                switch Result {
                case .success:
                    print("success last seen")
                    
                case .failure:
                    print("no last seen")
                    
                }
                dispatchSemaphore.signal()
            }
            
        }
    }
    
    func deckCarousel(reader: GeometryProxy) -> some View{
        let screenSize =  reader.size
        let itemWidth: CGFloat = screenSize.width * 0.62
        let paddingX: CGFloat = (screenSize.width - itemWidth) / 2
        
        
//        CloudKitManager.shared.fetchDeckSortBy(sortType: SortBy.alphabet) { Result in
//
//            switch Result {
//            case .success:
//                print("success importance alphabet")
//
//            case .failure:
//                print("no importance alphabet")
//            }
//        }
        
        return ScrollView(.horizontal,showsIndicators: false) {
        
            HStack{
                ForEach(cloudkitManager.allDecks) { i in
                    EmptyView()
                    HorizontalScrollView(deck: i, screenSize: screenSize, width: itemWidth, paddingX: paddingX)
                    
                }
            }
            .padding(.horizontal, paddingX)
        }
    }
}
struct DecksScrollView: View {
    @State var selectedDecks: Int
    @EnvironmentObject private var cloudkitManager: CloudKitManager
    
    var body: some View {
        TabView(selection: $selectedDecks) {
            HStack(alignment: .center){
                VStack(){
                    Button {
                        print("new card")
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
                                .frame(width: 23, height: 24)

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
                    .padding(UIScreen.main.bounds.size.height * 0.038)

                }

                HStack(){

                    ForEach(cloudkitManager.allDecks){ i in
                        EmptyView()
                        SingleDeckView(deck: i)
                        .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.25)
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .onReceive(cloudkitManager.$decksCount) { decks in
            withAnimation {
                selectedDecks = decks
            }
        }
    }
}
struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



