//
//  UserChoices.swift
//  DailyVita
//
//  Created by Kaung Khant Si Thu on 13/11/2024.
//

import Foundation
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
        let jsonDict: [String: Any] = [
            "health_concerns": selectedConcerns.enumerated().map { index, concern in
                [
                    "id": index + 1,
                    "name": concern,
                    "priotity": index + 1
                ]
            },
            "diets":
                selectedDiets.enumerated().map { index, diet in
                    [
                        "id": index + 1,
                        "name": diet
                    ]
                },
            "is_daily_exposure": isDailyExposure,
            "is_somke": isSmoke,
            "alchol": alcohol,
            "allergies": selectedAllergies.enumerated().map { index, allergy in
                [
                    "id": index + 1,
                    "name": allergy
                ]
            }
        ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
        }
    }
}
