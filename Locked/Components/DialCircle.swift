import SwiftUI

struct DialCircle: View {
    let width : CGFloat
    let colour : Color
    let shouldApplyShadow : Bool
    
    var body: some View {
        Circle()
            .fill(colour)
            .frame(width: width)   
            .if(shouldApplyShadow) { view in
                view
                    .shadow(color: .black.opacity(0.5), radius: 3, x: -5, y: 5)
            }
    }
}
