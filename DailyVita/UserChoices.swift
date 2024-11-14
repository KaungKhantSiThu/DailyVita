//
//  UserChoices.swift
//  DailyVita
//
//  Created by Kaung Khant Si Thu on 13/11/2024.
//

import Combine

// User's choices model
class UserChoices: ObservableObject {
    @Published var selectedConcerns: [String] = []
    @Published var selectedDiets: [String] = []
    @Published var selectedAllergies: [String] = []
    
    @Published var isDailyExposure: Bool = false
    @Published var isSmoke: Bool = false
    @Published var alcohol: String = ""
    
    func printSummary() {
        print("Selected Health Concerns (Ordered): \(selectedConcerns)")
        print("Selected Diets: \(selectedDiets)")
        print("Selected Allergies: \(selectedAllergies)")
        print("Daily Exposure \(isDailyExposure)")
        print("Smoke: \(isSmoke)")
        print("Alcohol: \(alcohol)")
    }
}
