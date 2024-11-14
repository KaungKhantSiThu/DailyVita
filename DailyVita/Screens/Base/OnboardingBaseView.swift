import SwiftUI

protocol OnboardingViewModel: ObservableObject {
    associatedtype Option: Codable
    var options: [Option] { get set }
    var error: Error? { get set }
    func loadOptions()
}

struct OnboardingBaseView<Content: View, ViewModel: OnboardingViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    let title: String
    let position: OnboardingPosition
    let onNext: () -> Void
    let onBack: () -> Void
    let content: Content
    let isNextEnabled: Bool
    
    enum OnboardingPosition {
        case start
        case middle
        case end
        
        var nextButtonText: String {
            switch self {
            case .start: return "Get Started"
            case .middle: return "Next"
            case .end: return "Get my personalized vitamin"
            }
        }
        
        var nextButtonColor: Color {
            switch self {
            case .end: return .green
            default: return .blue
            }
        }
    }
    
    init(
        viewModel: ViewModel,
        title: String,
        position: OnboardingPosition,
        onNext: @escaping () -> Void,
        onBack: @escaping () -> Void,
        isNextEnabled: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.viewModel = viewModel
        self.title = title
        self.position = position
        self.onNext = onNext
        self.onBack = onBack
        self.isNextEnabled = isNextEnabled
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.title3)
                .padding(.bottom)
            
            content
            
            Spacer()
            
            navigationButtons
        }
        .onAppear {
            viewModel.loadOptions()
        }
        .alert(isPresented: .constant(viewModel.error != nil)) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.error?.localizedDescription ?? "An unknown error occurred"),
                dismissButton: .default(Text("OK")) {
                    viewModel.error = nil // Reset the error after dismissing the alert
                }
            )
        }
    }
    
    private var navigationButtons: some View {
        HStack {
            if position == .middle {
                Button(action: onBack) {
                    Text("Back")
                        .foregroundColor(.blue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
            }
            
            Button(action: onNext) {
                Text(position.nextButtonText)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(position.nextButtonColor.opacity(isNextEnabled ? 1 : 0.5))
                    .cornerRadius(10)
            }
            .disabled(!isNextEnabled)
        }
    }
} 
