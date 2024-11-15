//
//  LifestyleQuestionsViewModel.swift
//  DailyVita
//
//  Created by Kaung Khant Si Thu on 13/11/2024.
//

import Foundation

class LifestyleQuestionsViewModel: OnboardingViewModel {
    @Published var options: [Question] = []
    @Published var error: Error?

    @Published var isDailyExposure: Bool?
    @Published var isSmoke: Bool?
    @Published var alcohol: String?
    
    let userChoices: UserChoices
    
    init(userChoices: UserChoices) {
        self.userChoices = userChoices
    }
    
    func loadOptions() {
        options = Question.data
    }
    
    var isComplete: Bool {
        isDailyExposure != nil && isSmoke != nil && alcohol != nil
    }
    
    func updateAnswer(for question: Question, with answer: String) {
        switch question.id {
        case 1: // Daily sun exposure
            isDailyExposure = answer == "Yes"
        case 2: // Smoking
            isSmoke = answer == "Yes"
        case 3: // Alcohol
            alcohol = answer
        default:
            break
        }
        saveChoices()
    }
    
    func isSelected(answer: String, for question: Question) -> Bool {
        switch question.id {
        case 1:
            guard let isDailyExposure = isDailyExposure else { return false }
            return (answer == "Yes") == isDailyExposure
        case 2:
            guard let isSmoke = isSmoke else { return false }
            return (answer == "Yes") == isSmoke
        case 3:
            return alcohol == answer
        default:
            return false
        }
    }
    
    func saveChoices() {
        guard let isDailyExposure = isDailyExposure,
              let isSmoke = isSmoke,
              let alcohol = alcohol else { return }
        
        userChoices.isDailyExposure = isDailyExposure
        userChoices.isSmoke = isSmoke
        userChoices.alcohol = alcohol
    }
}
