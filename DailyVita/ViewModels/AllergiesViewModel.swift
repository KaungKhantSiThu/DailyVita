//
//  AllergiesViewModel.swift
//  DailyVita
//
//  Created by Kaung Khant Si Thu on 13/11/2024.
//

import Foundation

class AllergiesViewModel: OnboardingViewModel {
    @Published var options: [Allergy] = []
    @Published var error: Error?

    @Published var selectedAllergies: Set<Allergy> = [] {
        didSet {
            userChoices.selectedAllergies = Array(selectedAllergies.map(\.name))
        }
    }
    
    private var userChoices: UserChoices
    
    init(userChoices: UserChoices) {
        self.userChoices = userChoices
    }
    
    func loadOptions() {
        do {
            let jsonLoader = JSONLoader()
            let response = try jsonLoader.decode(GenericResponse<Allergy>.self, from: "allergies")
            options = response.data
        } catch {
            self.error = error
        }
    }
}
