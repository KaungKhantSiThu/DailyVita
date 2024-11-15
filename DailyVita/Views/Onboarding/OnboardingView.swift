import SwiftUI

struct OnboardingView: View {
    @StateObject private var userChoices = UserChoices()
    @State private var currentStep: OnboardingStep = .welcome
    
    var body: some View {
        VStack {
            switch currentStep {
            case .welcome:
                WelcomeView {
                    navigateToNextStep()
                }
            case .healthConcerns:
                HealthConcernsView(userChoices: userChoices,
                                   onNext: navigateToNextStep,
                                   onBack: navigateToPreviousStep
                )
            case .diets:
                DietsView(userChoices: userChoices,
                          onNext: navigateToNextStep,
                          onBack: navigateToPreviousStep
                )
            case .allergies:
                AllergiesView(userChoices: userChoices,
                              onNext: navigateToNextStep,
                              onBack: navigateToPreviousStep
                )

                case .lifestyleQuestions:
            LifestyleQuestionsView(userChoices: userChoices,
                                 onNext: { userChoices.printSummary() },
                                 onBack: navigateToPreviousStep
            )
            }
            
            if currentStep != .welcome {
                ProgressView(value: Double(currentStep.rawValue),
                             total: Double(OnboardingStep.allCases.count - 1))
            }
        }
        .padding()
    }
    
    private func navigateToNextStep() {
        withAnimation {
            if let nextStep = currentStep.next() {
                currentStep = nextStep
            }
        }
    }
    
    private func navigateToPreviousStep() {
        withAnimation {
            if let previousStep = currentStep.previous() {
                currentStep = previousStep
            }
        }
    }
}
