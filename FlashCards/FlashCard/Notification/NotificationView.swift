//
//  NotificationView.swift
//  FlashCards
//
//  Created by Hojin Ryu on 21/10/21.
//

import Foundation
import SwiftUI

struct NotificationView: View {
    
    var notificationManager = NotificationManager()
    
    
    var body: some View {
        VStack {
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
                })
            }
            
            Divider()
            Button("delete all notifications") {
                notificationManager.stopSending()
            }
        }
    }
}



struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
