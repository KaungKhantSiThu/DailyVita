import SwiftUI

protocol OnboardingViewModel: ObservableObject {
    associatedtype Option: Codable
    var options: [Option] { get set }
    var error: Error? { get set }
    func loadOptions()
}

struct OnboardingBaseView<Content: View, ViewModel: OnboardingViewModel>: View {
    @EnvironmentObject var themeManager: ThemeManager
    @ObservedObject var viewModel: ViewModel
    
    let title: String?
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
    }
    
    init(
        viewModel: ViewModel,
        title: String? = nil,
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
        VStack(spacing: themeManager.currentTheme.spacing) {
            if let title {
                Text(title)
                    .titleStyle()
                    .padding(.top)
                    .padding(.bottom, themeManager.currentTheme.padding)
            }
            
            content
            
            Spacer()
            
            navigationButtons
        }
        .padding(themeManager.currentTheme.padding)
        .background(themeManager.currentTheme.backgroundColor)
        .onAppear {
            viewModel.loadOptions()
        }
        .alert(isPresented: .constant(viewModel.error != nil)) {
            Alert(
                title: Text("Error")
                    .font(themeManager.currentTheme.headlineFont),
                message: Text(viewModel.error?.localizedDescription ?? "An unknown error occurred")
                    .font(themeManager.currentTheme.bodyFont),
                dismissButton: .default(Text("OK")) {
                    viewModel.error = nil
                }
            )
        }
    }
    
    private var navigationButtons: some View {
        HStack(spacing: themeManager.currentTheme.spacing) {
            if position == .middle {
                backButton
            }
            
            nextButton
        }
    }
    
    private var backButton: some View {
        Button(action: onBack) {
            Text("Back")
                .font(themeManager.currentTheme.buttonFont)
                .foregroundColor(themeManager.currentTheme.primaryColor)
                .padding(.vertical, themeManager.currentTheme.padding)
                .frame(maxWidth: .infinity)
                .background(themeManager.currentTheme.secondaryColor.opacity(0.1))
                .cornerRadius(themeManager.currentTheme.cornerRadius)
        }
    }
    
    private var nextButton: some View {
        Button(action: onNext) {
            Text(position.nextButtonText)
                .font(themeManager.currentTheme.buttonFont)
                .foregroundColor(.white)
                .padding(.vertical, themeManager.currentTheme.padding)
                .frame(maxWidth: .infinity)
                .background(
                    isNextEnabled ?
                    themeManager.currentTheme.primaryColor :
                    themeManager.currentTheme.primaryColor.opacity(0.5)
                )
                .cornerRadius(themeManager.currentTheme.cornerRadius)
        }
        .disabled(!isNextEnabled)
    }
} 
