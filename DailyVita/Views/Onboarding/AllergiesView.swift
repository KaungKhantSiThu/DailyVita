import SwiftUI

struct AllergiesView: View {
    @StateObject private var viewModel: AllergiesViewModel
    @State private var searchText = ""
    let onNext: () -> Void
    let onBack: () -> Void
    
    init(userChoices: UserChoices, onNext: @escaping () -> Void, onBack: @escaping () -> Void) {
            _viewModel = StateObject(wrappedValue: AllergiesViewModel(userChoices: userChoices))
        self.onNext = onNext
            self.onBack = onBack
        }
    
    var filteredSuggestions: [Allergy] {
        guard !searchText.isEmpty else { return [] }
        return viewModel.options.filter { $0.name.localizedCaseInsensitiveContains(searchText) && !viewModel.selectedAllergies.contains($0) }
    }
    
    var body: some View {
        OnboardingBaseView(
            viewModel: viewModel,
            position: .middle,
            onNext: onNext,
            onBack: onBack
        ) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Specify any allergies or sensitivities.")
                    .font(.headline)
                
                TextField("Enter allergies here", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Suggestions List
                if !filteredSuggestions.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(filteredSuggestions) { allergy in
                            Button(action: {
                                viewModel.selectedAllergies.insert(allergy)
                                searchText = ""
                            }) {
                                Text(allergy.name)
                                    .foregroundColor(.primary)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                            }
                            Divider()
                        }
                    }
                    .padding(.horizontal)
                    .background(Color(.systemBackground))
                }
                
                Spacer()
                
                // Selected Allergies Flow Layout
                FlowLayout(spacing: 8) {
                    ForEach(Array(viewModel.selectedAllergies)) { allergy in
                        Chip(text: allergy.name) {
                            viewModel.selectedAllergies.remove(allergy)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

// Chip View for selected allergies
struct Chip: View {
    let text: String
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            Text(text)
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}

#Preview {
    AllergiesView(userChoices: UserChoices()) {
        // do nothing
    } onBack: {
        // do nothing
    }
}
