//
//  FlashCardsApp.swift
//  FlashCards
//
//  Created by João Brentano on 13/10/21.
//

import SwiftUI
import SafariServices

@main
struct FlashCardsApp: App {
    @State var sharing = "com.FlashCard"
    @StateObject private var cloudkitManager: CloudKitManager = CloudKitManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cloudkitManager)
            
        }
    }
    
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        if didLoadSuccessfully == true {
            print("succ")
        } else {
            print("fail")
        }
    }
}
