import SwiftUI

class ThemeManager: ObservableObject {
    @Published var currentTheme: ThemeProtocol
    
    init(theme: ThemeProtocol = DefaultTheme()) {
        self.currentTheme = theme
    }
}

// Protocol defining what a theme must provide
protocol ThemeProtocol {
    // Colors
    var primaryColor: Color { get }
    var secondaryColor: Color { get }
    var backgroundColor: Color { get }
    var textPrimaryColor: Color { get }
    var textSecondaryColor: Color { get }
    
    // Typography
    var titleFont: Font { get }
    var headlineFont: Font { get }
    var bodyFont: Font { get }
    var buttonFont: Font { get }
    
    // Spacing
    var spacing: CGFloat { get }
    var padding: CGFloat { get }
    
    // Corner Radius
    var cornerRadius: CGFloat { get }
} 