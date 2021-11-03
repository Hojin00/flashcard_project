//
//  CardStatusView.swift
//  FlashCards
//
//  Created by Lucca Molon on 29/10/21.
//

import SwiftUI

struct CardStatusView: View {
    
    let screenSize: CGSize = UIScreen.main.bounds.size
    let status: StatusType
    let opacity: Double
    
    init(status: StatusType, opacity: Double) {
        self.status = status
        self.opacity = opacity
    }
    
    var body: some View {
        if status == .exclamation {
            Image(systemName: "exclamationmark.3")
                .resizable()
                .foregroundColor(.gray)
                .opacity(opacity)
                .frame(width: screenSize.width * 0.04, height: screenSize.width * 0.04)
        } else {
            Image(systemName: "alarm")
                .resizable()
                .foregroundColor(.gray)
                .opacity(opacity)
                .frame(width: screenSize.width * 0.04, height: screenSize.width * 0.04)
        }
    }
}

enum StatusType {
    case exclamation, clock
}

struct CardStatusView_Previews: PreviewProvider {
    static var previews: some View {
        CardStatusView(status: .clock, opacity: 0.5)
    }
}
