//
//  MenuView.swift
//  FlashCards
//
//  Created by Lucca Molon on 10/11/21.
//

import SwiftUI

struct CustomModalView: View {
    
    @Binding var isShowing: Bool
    @State private var isDragging = false
    
    @State private var currentHeight: CGFloat = UIScreen.main.bounds.height/2
    let minHeight: CGFloat = UIScreen.main.bounds.height/2 - 60
    let maxHeight: CGFloat = UIScreen.main.bounds.height/2
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.black
                    .ignoresSafeArea()
                    .opacity(0.3)
                    .onTapGesture {
                        isShowing = false
                    }
                mainView
                .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut)
    }
    
    var mainView: some View {
        VStack {
            ZStack {
                Capsule()
                    .frame(width: 40, height: 6)
                    .opacity(0.5)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            .gesture(dragGesture)
            ZStack {
                Text("hello")
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 35)
        }
        .frame(height: currentHeight)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 20))
        .animation(isDragging ? nil : .easeInOut(duration: 0.45))
    }
    
    @State private var prevDragTranslation = CGSize.zero
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { val in
                if !isDragging {
                    isDragging = true
                }
                let dragAmount = val.translation.height - prevDragTranslation.height
                if currentHeight > maxHeight || currentHeight < minHeight {
                    currentHeight -= dragAmount/6
                } else {
                    currentHeight -= dragAmount
                }
                prevDragTranslation = val.translation
            }
            .onEnded { val in
                prevDragTranslation = .zero
                isDragging = false
                if currentHeight > maxHeight {
                    currentHeight = maxHeight
                } else if currentHeight < maxHeight && currentHeight > minHeight {
                    currentHeight = maxHeight
                } else if currentHeight < minHeight {
                    currentHeight = maxHeight
                    isShowing = false
                }
            }
    }
}


struct Menu: View {
    var body: some View {
        ZStack {
            Color.blue
            VStack {
                Text("aaa")
            }
        }
    }
}



struct CustomModalView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
        //CustomModalView(isShowing: .constant(true))
    }
}
