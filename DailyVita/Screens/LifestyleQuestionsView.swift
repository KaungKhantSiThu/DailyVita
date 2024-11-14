import SwiftUI

struct LifestyleQuestionsView: View {
    @StateObject private var viewModel: LifestyleQuestionsViewModel
    let onNext: () -> Void
    let onBack: () -> Void
    
    init(userChoices: UserChoices, onNext: @escaping () -> Void, onBack: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: LifestyleQuestionsViewModel(userChoices: userChoices))
        self.onNext = onNext
        self.onBack = onBack
    }
    
    var body: some View {
        OnboardingBaseView(
            viewModel: viewModel,
            title: "Lifestyle Questions",
            position: .end,
            onNext: onNext,
            onBack: onBack,
            isNextEnabled: viewModel.isComplete
        ) {
            VStack(spacing: 24) {
                ForEach(viewModel.options) { question in
                    QuestionView(question: question, viewModel: viewModel)
                }
            }
        }
    }
}

struct QuestionView: View {
    let question: Question
    @ObservedObject var viewModel: LifestyleQuestionsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(question.text)
                .font(.headline)
            
            VStack(spacing: 8) {
                ForEach(question.answers, id: \.self) { answer in
                    AnswerButton(
                        answer: answer,
                        isSelected: viewModel.isSelected(answer: answer, for: question),
                        action: {
                            viewModel.updateAnswer(for: question, with: answer)
                        }
                    )
                }
            }
        }
    }
}

struct AnswerButton: View {
    let answer: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isSelected ? .blue : .gray)
                Text(answer)
                    .foregroundColor(isSelected ? .primary : .gray)
                Spacer()
            }
            .padding()
        }
        .font(.headline)
        .buttonStyle(.plain)
    }
}

#Preview {
    LifestyleQuestionsView(userChoices: UserChoices()) {
        // do nothing
    } onBack: {
        // do nothing
    }
} 
