import SwiftUI
import DesignSystem

struct ProjectHomeBackground: View {
    var body: some View {
        Rectangle()
            .fill(.background)
            .overlay(alignment: .topLeading) {
                RadialGradient(
                    colors: [
                        IMDFColor.accent.opacity(0.10),
                        .clear
                    ],
                    center: .topLeading,
                    startRadius: 20,
                    endRadius: 620
                )
                .allowsHitTesting(false)
            }
            .ignoresSafeArea()
    }
}
