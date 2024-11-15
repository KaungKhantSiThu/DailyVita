import SwiftUI

struct WelcomeView: View {
    @StateObject private var viewModel = WelcomeViewModel()

    let onNext: () -> Void
    
    var body: some View {
        OnboardingBaseView(
            viewModel: viewModel,
            title: "Welcome to DailyVita",
            position: .start,
            onNext: onNext,
            onBack: {}
        ) {
            
            VStack(spacing: 10) {
                Text("Hello, we are here to make your life healthier and happier")
                    .font(.callout)
                Image("doctors")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("We will ask a couple of questions to better understand your vitamin need")
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
        }
    }
} 
