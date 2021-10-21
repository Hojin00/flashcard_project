//
//  SearchView.swift
//  FlashCards
//
//  Created by Willian Magnum Albeche on 14/10/21.
//

import SwiftUI
import CloudKit

struct SearchView: View {
    private var flashCardsArray = [FlashCard.init(myrecord: CKRecord.init(recordType: "FlashCard"), frontSideText: "Arroz", frontSideImage: nil, backSideText: nil, backSideImage: nil, category: "Comida", frontSideAudio: nil, backSideAudio: nil),FlashCard.init(myrecord: CKRecord.init(recordType: "FlashCard"), frontSideText: "feijao", frontSideImage: nil, backSideText: nil, backSideImage: nil, category: "COMIDA", frontSideAudio: nil, backSideAudio: nil),FlashCard.init(myrecord: CKRecord.init(recordType: "FlashCard"), frontSideText: "Batata", frontSideImage: nil, backSideText: nil, backSideImage: nil, category: "Comida", frontSideAudio: nil, backSideAudio: nil)]
    
    @State private var searchText: String = ""
    var body: some View {
        VStack {
            
            SearchBar(text: $searchText)
                .padding(.top, -30)
            
            ForEach(flashCardsArray.filter({ searchText.isEmpty ? true : $0.frontSideText!.localizedCaseInsensitiveContains(searchText)}), id: \.self) { item in
                Text(item.frontSideText!)
            }
            Spacer()
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
