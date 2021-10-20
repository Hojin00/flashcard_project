//
//  ContentView.swift
//  FlashCards
//
//  Created by João Brentano on 13/10/21.
//

import SwiftUI



struct ContentView: View {
    
    var notificationManager = NotificationManager()
    
    var body: some View {
        
        VStack {
            ShareView()

            Button("auth") {
                notificationManager.authorization()
            }
            Divider()
            Button("aa") {
                notificationManager.send(identifier: UUID().uuidString, title: "hello friend", body: "how r u? XD", hour: 16, minute: 45)
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
//            CardView {
//                Text("Front")
//            } back: {
//                Text("Back")
//            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
