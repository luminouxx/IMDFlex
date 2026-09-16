import Foundation

public enum ProjectHomeRoute: Equatable, Hashable, Sendable {
    case workspace(projectID: UUID)
}
