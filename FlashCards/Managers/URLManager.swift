//
//  URLManager.swift
//  FlashCards
//
//  Created by Hojin Ryu on 15/10/21.
//


import UIKit
import SwiftUI

//struct ActivityViewController: UIViewControllerRepresentable {
//
//    static let shared: ActivityViewController = ActivityViewController()
//
//    var activityItems: [Any]!
//    var applicationActivities: [UIActivity]? = nil
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
//        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
//        return controller
//    }
//
//    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
//
//
//}
class Deeplinker {
    enum Deeplink: Equatable {
        case home
        case details(reference: String)
    }
    
    func manage(url: URL) -> Deeplink? {
        guard url.scheme == url.scheme else { return nil }
        guard url.pathComponents.contains(url.path) else { return .home }
        guard let query = url.query else { return nil }
        let components = query.split(separator: ",").flatMap { $0.split(separator: "=") }
        guard let idIndex = components.firstIndex(of: Substring(url.appReferenceQueryName)) else { return nil }
        guard idIndex + 1 < components.count else { return nil }
        
        return .details(reference: String(components[idIndex.advanced(by: 1)]))
    }
}
