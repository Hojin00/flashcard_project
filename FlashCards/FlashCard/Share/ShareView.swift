//
//  ShareView.swift
//  FlashCards
//
//  Created by Hojin Ryu on 15/10/21.
//

import Foundation
import SwiftUI

struct ShareView: View {
    @State private var showDetails = false
    
    var body: some View {
        Button("Share app") {
            self.showDetails = true
            
        }
        .sheet(isPresented: $showDetails, onDismiss: {
            print("Dismiss")
        }, content: {
            ActivityViewController(activityItems: [URL(string: "com.FlashCard://Deck?id=Ab312345bb")!], applicationActivities: nil)
        })
    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView()
    }
}
