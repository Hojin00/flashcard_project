//
//  Helper.swift
//  FlashCards
//
//  Created by Hojin Ryu on 28/10/21.
//

import Foundation
import SwiftUI


enum SortBy: String {

    case lastSeen, lastUpdated, alphabet, hadest, hardest, importance, importanceAlphabet,  none
    
    var id: String { self.rawValue }
    
    func getSortBy(withAscending: Bool) -> [NSSortDescriptor] {
        switch self {
        case .lastSeen:
            return [NSSortDescriptor(key: "lastView", ascending: withAscending)]
        case .lastUpdated:
            return [NSSortDescriptor(key: "modificationDate", ascending: withAscending)]
        case .alphabet:
            return [NSSortDescriptor(key: "title", ascending: withAscending)]
        case .hardest:
            return [NSSortDescriptor(key: "hardFlashcards", ascending: withAscending)]
        case .importance:
            return [NSSortDescriptor(key: "importance", ascending: withAscending)]
        case .importanceAlphabet:
            return [NSSortDescriptor(key: "importance", ascending: withAscending), NSSortDescriptor(key: "title", ascending: true)]
        default:
            return []
        }
    }
}


enum Side {
    case front, back
}

extension View {
    func scrollOffset(_ position: Binding<CGFloat>) -> some View {
        return ScrollViewWrapper(offset: position) { self }
    }
}

struct ScrollViewWrapper<Content>: View where Content : View {
    let offset: Binding<CGFloat>
    let content: () -> Content

    init(offset: Binding<CGFloat>, @ViewBuilder content: @escaping () -> Content) {
        self.offset = offset
        self.content = content
    }

    var body: some View {
        ScrollViewRepresentable(offset: offset, content: self.content())
    }
}

struct ScrollViewRepresentable<Content>: UIViewControllerRepresentable where Content: View {
    typealias UIViewControllerType = ScrollViewUIHostingController<Content>
    
    @Binding var offset: CGFloat
    let content: Content
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScrollViewRepresentable<Content>>) -> ScrollViewUIHostingController<Content> {
        return ScrollViewUIHostingController(offset: self.$offset, rootView: self.content)
    }
    
    func updateUIViewController(_ uiViewController: ScrollViewUIHostingController<Content>, context: UIViewControllerRepresentableContext<ScrollViewRepresentable<Content>>) {
        uiViewController.scroll(position: self.offset)
    }
}

class ScrollViewUIHostingController<Content>: UIHostingController<Content> where Content : View {
    var offset: Binding<CGFloat>
    
    var ready = false
    var scrollView: UIScrollView? = nil
    
    init(offset: Binding<CGFloat>, rootView: Content) {
        self.offset = offset
        super.init(rootView: rootView)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        override func viewDidAppear(_ animated: Bool) {
        // observer is added from viewDidAppear, in order to
        // make sure the SwiftUI view is already in place
        if ready { return } // avoid running more than once
        
        ready = true
        
        self.scrollView = findUIScrollView(view: self.view)
        
        self.scrollView?.addObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset), options: [.old, .new], context: nil)
        
        self.scroll(position: self.offset.wrappedValue, animated: false)
        super.viewDidAppear(animated)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(UIScrollView.contentOffset) {
            if let sv = self.scrollView {
                DispatchQueue.main.async {
                    self.offset.wrappedValue = sv.contentOffset.y
                }
            }
        }
    }
    
    func scroll(position: CGFloat, animated: Bool = true) {
        if let sv = self.scrollView {
            if position != sv.contentOffset.y {
                self.scrollView?.setContentOffset(CGPoint(x: 0, y: position), animated: animated)
            }
        }
    }
    
    func findUIScrollView(view: UIView?) -> UIScrollView? {
        if view?.isKind(of: UIScrollView.self) ?? false {
            return (view as? UIScrollView)
        }
        
        for v in view?.subviews ?? [] {
            if let vc = findUIScrollView(view: v) {
                return vc
            }
        }
        
        return nil
    }
    
    deinit {
        self.scrollView?.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset))
    }
}
