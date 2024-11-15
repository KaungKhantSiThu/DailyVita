//
//  DietsViewModel.swift
//  DailyVita
//
//  Created by Kaung Khant Si Thu on 13/11/2024.
//

import Foundation

class DietsViewModel: OnboardingViewModel {
    @Published var options: [Diet] = []
    @Published var error: Error?

    @Published var selectedDiets: Set<Diet> = [] {
        didSet {
            userChoices.selectedDiets = Array(selectedDiets.map(\.name))
        }
    }
    
    private var userChoices: UserChoices
    
    init(userChoices: UserChoices) {
        self.userChoices = userChoices
    }
    
    func loadOptions() {
        do {
            let jsonLoader = JSONLoader()
            let response = try jsonLoader.decode(GenericResponse<Diet>.self, from: "Diets")
            options = response.data
        } catch {
            self.error = error
        }
    }
}


