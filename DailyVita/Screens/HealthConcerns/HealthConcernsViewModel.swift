//
//  HealthConcernsViewModel.swift
//  DailyVita
//
//  Created by Kaung Khant Si Thu on 13/11/2024.
//

import Foundation

class HealthConcernsViewModel: OnboardingViewModel {
    @Published var options: [HealthConcern] = []
    @Published var error: Error?

    @Published var selectedConcerns: [HealthConcern] = [] {
        didSet {
            userChoices.selectedConcerns = selectedConcerns.map(\.name)
        }
    }
    @Published var displayedConcerns: [HealthConcern] = []
    
    private var userChoices: UserChoices
    
    init(userChoices: UserChoices) {
        self.userChoices = userChoices
    }
    
    func loadOptions() {
        do {
            let jsonLoader = JSONLoader()
            let response = try jsonLoader.decode(GenericResponse<HealthConcern>.self, from: "Healthconcern")
            options = response.data
            displayedConcerns = selectedConcerns
        } catch {
            self.error = error
        }
    }
    
    func reorderConcerns(from source: IndexSet, to destination: Int) {
        displayedConcerns.move(fromOffsets: source, toOffset: destination)
        selectedConcerns = displayedConcerns
    }
    
    func toggleConcern(_ concern: HealthConcern) {
        if let index = selectedConcerns.firstIndex(where: { $0.id == concern.id }) {
            selectedConcerns.remove(at: index)
        } else if selectedConcerns.count < 5 {
            selectedConcerns.append(concern)
        }
        displayedConcerns = selectedConcerns
    }
}

struct HealthConcern: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
}
