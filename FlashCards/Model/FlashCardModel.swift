//
//  FlashCardModel.swift
//  FlashCards
//
//  Created by João Brentano on 13/10/21.
//

import Foundation
import SwiftUI

struct FlashCard: Hashable {
    
    //TO DO: Audio for front and back side
    var id: Int
    let frontSideText: String?
    let frontSideImage: Image?
    let backSideText: String?
    let backSideImage: Image?
    let category: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
