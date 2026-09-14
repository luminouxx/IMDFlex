import SwiftUI

public enum IMDFMotionMode: CaseIterable, Equatable, Sendable {
    case standard
    case reduced

    public func allowsSpatialMotion(systemReduceMotion: Bool) -> Bool {
        self == .standard && !systemReduceMotion
    }
}

public extension EnvironmentValues {
    @Entry var imdfMotionMode: IMDFMotionMode = .standard
}

public extension View {
    func imdfMotionMode(_ mode: IMDFMotionMode) -> some View {
        environment(\.imdfMotionMode, mode)
    }
}
