import SwiftUI

class Utils {
    static func isIpad() -> Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static func adjustedFontSize(dynamicTypeSize: DynamicTypeSize, size: CGFloat) -> CGFloat {
        switch dynamicTypeSize {
        case .xSmall:
            return size * 0.8
        case .small:
            return size * 0.9
        default:
            return size
        }
    }
    
    static func triggerHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}

// MARK: - Custom Font
enum CustomFont : String {
    case regular = "OpenSans"
    case italic = "OpenSans-Italic"
    case light = "OpenSans-Light"
    case semibold = "OpenSans-Semibold"
    case bold = "OpenSans-Bold"
    case boldItalic = "OpenSans-BoldItalic"
    case extrabold = "OpenSans-Extrabold"

    func getFont(dynamicTypeSize : DynamicTypeSize, size : CGFloat) -> Font {
        Font.custom(self.rawValue, size: Utils.adjustedFontSize(dynamicTypeSize: dynamicTypeSize, size: size))
    }
}
