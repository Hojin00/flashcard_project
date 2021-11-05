//
//  FlashCardsApp.swift
//  FlashCards
//
//  Created by João Brentano on 13/10/21.
//

import SwiftUI

@main
struct FlashCardsApp: App {
    @State var sharing = "com.FlashCard"
    @StateObject private var cloudkitManager: CloudKitManager = CloudKitManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    if let scheme = url.scheme,
                       scheme.localizedCaseInsensitiveCompare("com.FlashCard") == .orderedSame,
                       let view = url.host {
                        
                        var parameters: [String: String] = [:]
                        URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                            parameters[$0.name] = $0.value
                        }
                        print("para", parameters)
                        sharing += "://"
                        sharing += view + "/"
                        
                        print(sharing)
                    }
                }
                .environmentObject(cloudkitManager)
        }
    }
}
