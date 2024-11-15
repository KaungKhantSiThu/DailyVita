import SwiftUI

struct TitleStyle: ViewModifier {
    @EnvironmentObject var themeManager: ThemeManager
    
    func body(content: Content) -> some View {
        content
            .font(themeManager.currentTheme.titleFont)
            .foregroundColor(themeManager.currentTheme.textPrimaryColor)
    }
}

struct HeadlineStyle: ViewModifier {
    @EnvironmentObject var themeManager: ThemeManager
    
    func body(content: Content) -> some View {
        content
            .font(themeManager.currentTheme.headlineFont)
            .foregroundColor(themeManager.currentTheme.textPrimaryColor)
    }
}

struct BodyStyle: ViewModifier {
    @EnvironmentObject var themeManager: ThemeManager
    
    func body(content: Content) -> some View {
        content
            .font(themeManager.currentTheme.bodyFont)
            .foregroundColor(themeManager.currentTheme.textPrimaryColor)
    }
}

// Add View extensions for easy usage
extension View {
    func titleStyle() -> some View {
        modifier(TitleStyle())
    }
    
    func headlineStyle() -> some View {
        modifier(HeadlineStyle())
    }
    
    func bodyStyle() -> some View {
        modifier(BodyStyle())
    }
} 