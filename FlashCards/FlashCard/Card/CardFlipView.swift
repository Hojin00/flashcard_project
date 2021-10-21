import Foundation
import SwiftUI

struct CardFlipView: View {
    
    var body: some View {
        CardView {
           Text("Front")
        } back: {
            Text("Back")
        }
    }
}

struct CardFlipView_Previews: PreviewProvider {
    static var previews: some View {
        CardFlipView()
    }
}