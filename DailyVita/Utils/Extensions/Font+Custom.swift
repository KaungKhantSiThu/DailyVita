import SwiftUI

extension Font {
    enum PoppinsFont {
        case regular
        case medium
        case semiBold
        case bold
        
        var value: String {
            switch self {
            case .regular: return "Poppins-Regular"
            case .medium: return "Poppins-Medium"
            case .semiBold: return "Poppins-SemiBold"
            case .bold: return "Poppins-Bold"
            }
        }
    }
    
    static func poppins(_ type: PoppinsFont, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
} 