import SwiftUI

struct IMDFPressFeedbackStyle: ButtonStyle {
    @Environment(\.accessibilityReduceMotion) private var systemReduceMotion
    @Environment(\.imdfMotionMode) private var motionMode

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.64 : 1)
            .scaleEffect(pressedScale(configuration: configuration))
            .animation(pressAnimation, value: configuration.isPressed)
    }

    private func pressedScale(configuration: Configuration) -> CGFloat {
        guard motionMode.allowsSpatialMotion(systemReduceMotion: systemReduceMotion) else {
            return 1
        }

        return configuration.isPressed ? 0.98 : 1
    }

    private var pressAnimation: Animation? {
        motionMode.allowsSpatialMotion(systemReduceMotion: systemReduceMotion)
            ? .easeOut(duration: 0.12)
            : nil
    }
}
