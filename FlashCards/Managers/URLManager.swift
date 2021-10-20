//
//  URLManager.swift
//  FlashCards
//
//  Created by Hojin Ryu on 15/10/21.
//


import UIKit
import SwiftUI

struct ActivityViewController: UIViewControllerRepresentable {
    
    static let shared: ActivityViewController = ActivityViewController()
    
    var activityItems: [Any]!
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
    
    
}
