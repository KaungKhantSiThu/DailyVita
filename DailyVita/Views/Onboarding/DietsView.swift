import SwiftUI

struct DietsView: View {
    @StateObject private var viewModel: DietsViewModel
    @State private var isNoneSelected = false
//    @State private var selectedTooltip: String?
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
            position: .middle,
            onNext: onNext,
            onBack: onBack,
            isNextEnabled: !viewModel.selectedDiets.isEmpty || isNoneSelected
        ) {
            ZStack {
                VStack {
                    Text("Select the diets you follow.")
                        .font(.headline)
                    List {
                        Toggle("None", isOn: $isNoneSelected)
                            .toggleStyle(CheckBoxToggleStyle())
                            .onChange(of: isNoneSelected) { _, newValue in
                                if newValue {
                                    viewModel.selectedDiets.removeAll()
//                                    selectedTooltip = nil
                                }
                            }
                        ForEach(viewModel.options) { diet in
                            HStack {
                                Toggle(diet.name, isOn: Binding(
                                    get: { viewModel.selectedDiets.contains(diet) },
                                    set: { selected in
                                        if selected {
                                            isNoneSelected = false
                                            viewModel.selectedDiets.insert(diet)
                                        } else {
                                            viewModel.selectedDiets.remove(diet)
                                        }
//                                        selectedTooltip = nil
                                    }
                                ))
                                .toggleStyle(CheckBoxToggleStyle())
                                
                                Button {
//                                    if selectedTooltip == diet.toolTip {
//                                        selectedTooltip = nil
//                                    } else {
//                                        selectedTooltip = diet.toolTip
//                                    }
                                } label: {
                                    Image(systemName: "info.circle")
                                }
                                .foregroundStyle(.blue)
//                                .overlay {
//                                    if selectedTooltip == diet.toolTip {
//                                        TooltipView(text: diet.toolTip)
//                                    }
//                                }
                            }
                            .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                }
                
//                if selectedTooltip != nil {
//                    Color.clear
//                        .onTapGesture {
//                            selectedTooltip = nil
//                        }
//                }
//                
//                if let tooltip = selectedTooltip {
//                    TooltipView(text: tooltip)
//                        .transition(.opacity)
//                }
            }
        }
    }
}

struct TooltipView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 4)
            .frame(maxWidth: 250)
    }
}

#Preview {
    DietsView(userChoices: UserChoices()) {
        // do nothing
    } onBack: {
        // do nothing
    }
    
}
