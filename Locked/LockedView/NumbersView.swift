import SwiftUI

struct NumbersView: View {
    
    var body: some View {
        HStack {
            numberView
            numberView
            numberView
            numberView
            numberView
        }        
    }
}

private extension NumbersView {
    var numberView : some View {
        VStack {
            Text("")
            dash
        }
    }
    
    var dash : some View {
        Rectangle()
            .fill(Color.primary)
            .frame(maxWidth: .infinity)
            .frame(height: 4)
    }
}
