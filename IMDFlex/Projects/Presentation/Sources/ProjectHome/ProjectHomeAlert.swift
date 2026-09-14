public enum ProjectHomeAlert: Equatable, Sendable {
    case invalidProjectName
    case loadingFailed
    case creationFailed
    case deletionFailed
}
