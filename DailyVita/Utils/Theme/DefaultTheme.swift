import SwiftUI

struct DefaultTheme: ThemeProtocol {
    
    // Colors
    let primaryColor = Color.accentColor
    let secondaryColor = Color.accentColor.opacity(0.4)
    let backgroundColor = Color(.systemBackground)
    let textPrimaryColor = Color.primary
    let textSecondaryColor = Color.secondary
    
    // Typography
    let titleFont = Font.custom("Poppins-Bold", size: 20)
    let headlineFont = Font.custom("Poppins-SemiBold", size: 18)
    let bodyFont = Font.custom("Poppins-Regular", size: 16)
    let buttonFont = Font.custom("Poppins-Medium", size: 16)
    
    // Spacing
    let spacing: CGFloat = 16
    let padding: CGFloat = 20
    
    // Corner Radius
    let cornerRadius: CGFloat = 12
} 
