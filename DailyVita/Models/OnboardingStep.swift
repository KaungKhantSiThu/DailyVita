//
//  OnboardingStep.swift
//  DailyVita
//
//  Created by Kaung Khant Si Thu on 13/11/2024.
//


enum OnboardingStep: Int, CaseIterable {
    case welcome
    case healthConcerns
    case diets
    case allergies
    case lifestyleQuestions
    var title: String {
        switch self {
        case .welcome: return "Welcome to DailyVita"
        case .healthConcerns: return "Select your top health concerns"
        case .diets: return "Select the diets you follow"
        case .allergies: return "Specify any allergies or sensitivities"
        case .lifestyleQuestions: return "Answer a few lifestyle questions"
        }
    }
    
    // Method to get the next step
    func next() -> OnboardingStep? {
        let allSteps = OnboardingStep.allCases
        if let currentIndex = allSteps.firstIndex(of: self), currentIndex < allSteps.count - 1 {
            return allSteps[currentIndex + 1]
        }
        return nil
    }
    
    // Method to get the previous step
    func previous() -> OnboardingStep? {
        let allSteps = OnboardingStep.allCases
        if let currentIndex = allSteps.firstIndex(of: self), currentIndex > 0 {
            return allSteps[currentIndex - 1]
        }
        return nil
    }
}