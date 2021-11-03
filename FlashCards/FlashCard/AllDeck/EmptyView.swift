//
//  EmptyView.swift
//  FlashCards
//
//  Created by João Brentano on 28/10/21.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width * 0.40, height: UIScreen.main.bounds.height * 0.25)
            .foregroundColor(Color.clear)
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
