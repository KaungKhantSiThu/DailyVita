//
//  WelcomeViewModel.swift
//  DailyVita
//
//  Created by Kaung Khant Si Thu on 13/11/2024.
//

import Foundation

class WelcomeViewModel: OnboardingViewModel {
    @Published var options: [String] = []
    @Published var error: Error?
    func loadOptions() { /* No options to load */ }
}
