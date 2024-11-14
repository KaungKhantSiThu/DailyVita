import SwiftUI

struct WelcomeView: View {
    @StateObject private var viewModel = WelcomeViewModel()
    let onNext: () -> Void
    
    var body: some View {
        OnboardingBaseView(
            viewModel: viewModel,
            title: "We will ask a couple of questions to better understand your vitamin needs.",
            position: .start,
            onNext: onNext,
            onBack: {}
        ) {
            Image("doctors")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
} 
