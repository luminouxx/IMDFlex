import Observation

public struct MapEditorRequirementDisplayState: Equatable, Sendable {
    public let title: String
    public let value: String
    public let isReady: Bool

    public init(title: String, value: String, isReady: Bool) {
        self.title = title
        self.value = value
        self.isReady = isReady
    }
}

public struct MapEditorDraftStatusDisplayState: Equatable, Sendable {
    public let title: String
    public let systemImage: String
    public let isReady: Bool

    public init(title: String, systemImage: String, isReady: Bool) {
        self.title = title
        self.systemImage = systemImage
        self.isReady = isReady
    }
}

@MainActor
@Observable
public final class MapEditorViewModel {
    private let authoringState: FeatureAuthoringToolState

    public init(authoringState: FeatureAuthoringToolState = FeatureAuthoringToolState()) {
        self.authoringState = authoringState
    }

    public var featureTools: [IMDFAuthoringFeatureDisplayDescriptor] {
        MapEditorDisplayDescriptor.features
    }

    public var selectedFeature: IMDFAuthoringFeature {
        authoringState.selectedFeature
    }

    public var selectedFeatureDescriptor: IMDFAuthoringFeatureDisplayDescriptor {
        MapEditorDisplayDescriptor.featureDescriptor(for: authoringState.selectedFeature)
    }

    public var geometryDescriptor: IMDFAuthoringGeometryDisplayDescriptor {
        MapEditorDisplayDescriptor.geometryDescriptor(for: authoringState.contract.geometry)
    }

    public var draftProgressText: String {
        "\(authoringState.draftedPointCount)/\(authoringState.contract.geometry.minimumPointCount)"
    }

    public var draftStatus: MapEditorDraftStatusDisplayState {
        if authoringState.canFinish {
            return .init(title: "Ready", systemImage: "checkmark.circle", isReady: true)
        }

        return .init(title: "Draft", systemImage: "clock", isReady: false)
    }

    public var categoryRequirement: MapEditorRequirementDisplayState? {
        guard authoringState.contract.requiresCategory else { return nil }

        return .init(
            title: "Category",
            value: authoringState.hasSelectedCategory ? "Selected" : "Required",
            isReady: authoringState.hasSelectedCategory
        )
    }

    public var referenceRequirement: MapEditorRequirementDisplayState {
        guard !authoringState.contract.requiredReferences.isEmpty else {
            return .init(title: "References", value: "None", isReady: true)
        }

        let missingReferences = authoringState.missingReferences
        let value = missingReferences.isEmpty
            ? "Linked"
            : missingReferences
                .map { MapEditorDisplayDescriptor.referenceDescriptor(for: $0).title }
                .joined(separator: ", ")

        return .init(
            title: "References",
            value: value,
            isReady: missingReferences.isEmpty
        )
    }

    public var canAddDraftPoint: Bool {
        authoringState.contract.geometry != .form
    }

    public var canRemoveDraftPoint: Bool {
        authoringState.draftedPointCount > 0
    }

    public var canFinishDraft: Bool {
        authoringState.canFinish
    }

    public func selectFeature(_ feature: IMDFAuthoringFeature) {
        authoringState.selectFeature(feature)
    }

    public func toggleCategorySelection() {
        authoringState.setCategorySelected(!authoringState.hasSelectedCategory)
    }

    public func satisfyRequiredReferences() {
        authoringState.satisfyRequiredReferences()
    }

    public func addDraftPoint() {
        authoringState.addDraftPoint()
    }

    public func removeLastDraftPoint() {
        authoringState.removeLastDraftPoint()
    }

    public func cancelDraft() {
        authoringState.cancel()
    }

    @discardableResult
    public func finishDraft() -> IMDFDrawingDraftResult? {
        authoringState.finishDrawingDraft()
    }
}
