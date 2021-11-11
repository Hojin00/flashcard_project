//
//  TestView.swift
//  FlashCards
//
//  Created by Lucca Molon on 11/11/21.
//

import SwiftUI

struct TestView: View {
    
    @State private var showModal = false
    
    var body: some View {
        VStack {
            ZStack {
                Button("show modal") {
                    showModal = true
                }
                CustomModalView(isShowing: $showModal)
            }
        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
