import SwiftUI

extension View {
    func `if` <V : View>(_ condition : Bool, modifier : (Self) -> V) -> some View {
        condition ? AnyView(modifier(self)) : AnyView(self)
    }
}
