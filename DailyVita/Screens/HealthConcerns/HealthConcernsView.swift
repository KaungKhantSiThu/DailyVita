import SwiftUI

struct HealthConcernsView: View {
    @StateObject private var viewModel: HealthConcernsViewModel
    let onNext: () -> Void
    let onBack: () -> Void

init(userChoices: UserChoices, onNext: @escaping () -> Void, onBack: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: HealthConcernsViewModel(userChoices: userChoices))
        self.onNext = onNext
        self.onBack = onBack
    }
    
    var body: some View {
        OnboardingBaseView(
            viewModel: viewModel,
            title: "Select the top health concerns (up to 5)",
            position: .middle,
            onNext: onNext,
            onBack: onBack,
            isNextEnabled: !viewModel.selectedConcerns.isEmpty
        ) {
            VStack(spacing: 20) {
                // Health concerns selection
                FlowLayout(spacing: 15) {
                    ForEach(viewModel.options) { concern in
                        ConcernButton(
                            title: concern.name,
                            isSelected: viewModel.selectedConcerns.contains(where: { $0.id == concern.id }),
                            action: { viewModel.toggleConcern(concern) }
                        )
                    }
                }
                
                // Prioritized list
                if !viewModel.selectedConcerns.isEmpty {
                    Text("Prioritize")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                        List {
                            ForEach(viewModel.displayedConcerns) { concern in
                                Text(concern.name)
                                .padding(10)
                                
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                                .padding(.trailing)
                                .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                .listRowSeparator(.hidden)
                            }
                            .onMove(perform: moveItem)
                        }
                        .listStyle(.plain)
                        .environment(\.editMode, .constant(.active))
                }
            }
            .padding()
        }
    }
    
    private func moveItem(from source: IndexSet, to destination: Int) {
        viewModel.reorderConcerns(from: source, to: destination)
    }
}

struct ConcernButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding(8)
                .padding(.horizontal, 10)
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
} 

#Preview {
    HealthConcernsView(userChoices: UserChoices()) {
        // do nothing
    } onBack: {
        // do nothing
    }

}

