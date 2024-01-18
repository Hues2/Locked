import SwiftUI

struct LockedView: View {
    @StateObject private var lockedViewModel : LockedViewModel   
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    init(lockManager : LockManager) {
        self._lockedViewModel = StateObject(wrappedValue: LockedViewModel(lockManager : lockManager))
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                title
                
                Spacer()
                NumbersView()
                
                Spacer()
                DialView(width: proxy.size.width)
                
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
            .font(CustomFont.extrabold.getFont(dynamicTypeSize: dynamicTypeSize, size: 50))
    }
}
