//
//  SearchView.swift
//  FlashCards
//
//  Created by Willian Magnum Albeche on 14/10/21.
//

import SwiftUI

struct SearchView: View {
    private var flashCardsArray = [FlashCard.init(id: 1, frontSideText: "Arroz", frontSideImage: nil, backSideText: nil, backSideImage: nil, category: "Comida"),FlashCard.init(id: 2, frontSideText: "feijao", frontSideImage: nil, backSideText: nil, backSideImage: nil, category: "COMIDA"),FlashCard.init(id: 3, frontSideText: "Batata", frontSideImage: nil, backSideText: nil, backSideImage: nil, category: "Comida")]
    
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
