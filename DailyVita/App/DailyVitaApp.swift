//
//  DailyVitaApp.swift
//  DailyVita
//
//  Created by Kaung Khant Si Thu on 13/11/2024.
//

import SwiftUI

@main
struct DailyVitaApp: App {
    @StateObject private var themeManager = ThemeManager()
    
    init() {
        // Register custom fonts
        registerCustomFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
        }
    }
    
    private func registerCustomFonts() {
        let fontNames = ["Poppins-Regular", "Poppins-Medium", "Poppins-SemiBold", "Poppins-Bold"]
        fontNames.forEach { fontName in
            guard let fontURL = Bundle.main.url(forResource: fontName, withExtension: "ttf"),
                  let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
                  let font = CGFont(fontDataProvider) else {
                print("Couldn't create font from data")
                return
            }
            
            var error: Unmanaged<CFError>?
            CTFontManagerRegisterGraphicsFont(font, &error)
        }
    }
}
