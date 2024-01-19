import SwiftUI

struct LockedView: View {
    @StateObject private var viewModel : LockedViewModel
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    init(lockManager : LockManager) {
        self._viewModel = StateObject(wrappedValue: LockedViewModel(lockManager : lockManager))
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                title
                
                Spacer()
                NumbersView(viewModel: viewModel)
                
                Spacer()
                DialView(viewModel: viewModel, width: proxy.size.width)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(Constants.padding)
        }
    }
}

private extension LockedView {
    var title : some View {
        Text("app_title".localizedString)
            .font(CustomFont.extrabold.getFont(dynamicTypeSize: dynamicTypeSize, size: Constants.extraLargeTitle))
    }
}
