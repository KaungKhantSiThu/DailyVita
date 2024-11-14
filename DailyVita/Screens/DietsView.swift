import SwiftUI

struct DietsView: View {
    @StateObject private var viewModel: DietsViewModel
    @State private var isNoneSelected = false
    let onNext: () -> Void
    let onBack: () -> Void
    
    init(userChoices: UserChoices, onNext: @escaping () -> Void, onBack: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: DietsViewModel(userChoices: userChoices))
        self.onNext = onNext
            self.onBack = onBack
        }
    
    var body: some View {
        OnboardingBaseView(
            viewModel: viewModel,
            title: "Select the diets you follow.",
            position: .middle,
            onNext: onNext,
            onBack: onBack,
            isNextEnabled: !viewModel.selectedDiets.isEmpty || isNoneSelected
        ) {
            List {
                Toggle("None", isOn: $isNoneSelected)
                    .toggleStyle(CheckBoxToggleStyle())
                    .onChange(of: isNoneSelected) { newValue in
                        if newValue {
                            viewModel.selectedDiets.removeAll()
                        }
                    }
                ForEach(viewModel.options) { diet in
                    Toggle(diet.name, isOn: Binding(
                        get: { viewModel.selectedDiets.contains(diet) },
                        set: { selected in
                            if selected {
                                isNoneSelected = false
                                viewModel.selectedDiets.insert(diet)
                            } else {
                                viewModel.selectedDiets.remove(diet)
                            }
                        }
                    ))
                    .toggleStyle(CheckBoxToggleStyle(tip: diet.toolTip))
                    .listRowSeparator(.hidden)
                }
                
            }
            .listStyle(.plain)
        }
    }
} 

#Preview {
    DietsView(userChoices: UserChoices()) {
        // do nothing
    } onBack: {
        // do nothing
    }

}
