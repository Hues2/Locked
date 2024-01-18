import SwiftUI

class Constants {
    // MARK: - Font Sizes
    static let largeTitle : CGFloat = 34.0
    static let title1 : CGFloat = 28.0
    static let title2 : CGFloat = 22.0
    static let title3 : CGFloat = 20.0
    static let headline : CGFloat = 17.0
    static let body : CGFloat = 17.0
    static let callout : CGFloat = 16.0
    static let subheadline : CGFloat = 15.0
    static let footnote : CGFloat = 13.0
    static let caption1 : CGFloat = 12.0
    static let caption2 : CGFloat = 11.0
    
    // Padding
    static let phonePadding : CGFloat = 20
    static let tabletPadding : CGFloat = 80
    static let padding : CGFloat = Utils.isIpad() ? tabletPadding : phonePadding
}
