//
//  ContentView.swift
//  FlashCards
//
//  Created by João Brentano on 13/10/21.
//

import SwiftUI

var notificationManager = NotificationManager()

struct ContentView: View {
    var body: some View {
        
        VStack {
            Button("auth") {
                notificationManager.Authorization()
            }
            Divider()
            Button("aa") {
                notificationManager.Send(identifier: UUID().uuidString, title: "hello friend", body: "how r u? XD", hour: 16, minute: 10)
                print("teste")
                notificationManager.notificationCenter.getPendingNotificationRequests(completionHandler: { requests in
                    for request in requests {
                        print(request)
                    }
                }
            )
        }
            Divider()
            Button("delete all notifications") {
                notificationManager.stopSending()
            }

    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
