import SwiftUI

struct LockedView: View {
    @StateObject private var lockedViewModel : LockedViewModel   
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    init(lockManager : LockManager) {
        self._lockedViewModel = StateObject(wrappedValue: LockedViewModel(lockManager : lockManager))
    }
    
    var body: some View {
        VStack {
            title
            
            dialView
        }
    }
}

private extension LockedView {
    var title : some View {
        Text("app_title".localizedString)
            .font(CustomFont.extrabold.getFont(dynamicTypeSize: dynamicTypeSize, size: Constants.largeTitle))
    }
    
    var dialView : some View {
        DialView()
    }
}
