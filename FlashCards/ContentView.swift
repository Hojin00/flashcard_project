//
//  ContentView.swift
//  FlashCards
//
//  Created by João Brentano on 13/10/21.
//

import SwiftUI
import CloudKit
import UIKit

struct ContentView: View {

    var body: some View {
        
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
                //.edgesIgnoringSafeArea([.top, .bottom])
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
