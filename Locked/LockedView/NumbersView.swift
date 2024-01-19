import SwiftUI

struct NumbersView: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @ObservedObject var viewModel : LockedViewModel
    
    var body: some View {
        HStack {
            ForEach(0..<5) { i in
                numberView(i)
            }
        }
    }
}

private extension NumbersView {
    func numberView(_ index : Int) -> some View {
        VStack(spacing: 0) {
            if let number = viewModel.attempt[safe: index] {
                Text("\(number)")
                    .font(CustomFont.extrabold.getFont(dynamicTypeSize: dynamicTypeSize, size: Constants.extraLargeTitle))
                    .foregroundStyle(viewModel.getNumberColour(index: index))
                    .transition(.scale)
            } else {
                Text("")
                    .font(CustomFont.extrabold.getFont(dynamicTypeSize: dynamicTypeSize, size: Constants.extraLargeTitle))
            }
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
