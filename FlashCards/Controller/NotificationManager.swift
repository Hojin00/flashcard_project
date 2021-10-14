//
//  NotificationManager.swift
//  FlashCards
//
//  Created by Lucca Molon on 14/10/21.
//

import Foundation
import UserNotifications

struct NotificationManager {
    
    static let shared = NotificationManager()
    
    let notificationCenter = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    
    func authorization() {
        notificationCenter.requestAuthorization(options: options) {
            (allow, error) in
            if !allow {
                print("User didn't allow notifications")
            }
        }
    }
    
    func content(title: String, body: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        content.badge = 1
        return content
    }
    
    func schedule(hour: Int, minute: Int) -> UNCalendarNotificationTrigger {
        let nextTriggerDate = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: nextTriggerDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        return trigger
    }
    
    func send(identifier: String, title: String, body: String, hour: Int, minute: Int) {
        let request = UNNotificationRequest(identifier: identifier, content: content(title: title, body: body), trigger: schedule(hour: hour, minute: minute))
        notificationCenter.add(request, withCompletionHandler: nil)
    }
    
    func stopSending() {
        notificationCenter.removeAllPendingNotificationRequests()
        notificationCenter.removeAllDeliveredNotifications()
    }
}
