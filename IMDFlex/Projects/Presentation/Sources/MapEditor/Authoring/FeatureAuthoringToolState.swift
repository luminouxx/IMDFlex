import Domain
import Foundation
import Observation

public enum IMDFAuthoringGeometry: String, Codable, CaseIterable, Hashable, Sendable {
    case point
    case line
    case polygon
    case form

    public var minimumPointCount: Int {
        switch self {
        case .point: 1
        case .line: 2
        case .polygon: 3
        case .form: 0
        }
    }
}

public enum IMDFAuthoringReference: String, Codable, CaseIterable, Hashable, Sendable {
    case building
    case level
    case unit
    case anchor
    case levelOrBuilding
    case relationshipEndpoints
}

public enum IMDFAuthoringFeature: String, Codable, CaseIterable, Hashable, Identifiable, Sendable {
    case address
    case venue
    case building
    case footprint
    case level
    case unit
    case opening
    case amenity
    case anchor
    case occupant
    case detail
    case fixture
    case geofence
    case kiosk
    case relationship
    case section

    public var id: String { rawValue }

    public var contract: IMDFAuthoringContract {
        switch self {
        case .address:
            .init(feature: self, geometry: .form)
        case .venue:
            .init(feature: self, geometry: .polygon, requiresCategory: true, categoryFeature: .venue)
        case .building:
            .init(feature: self, geometry: .form, requiresCategory: true, categoryFeature: .building)
        case .footprint:
            .init(
                feature: self,
                geometry: .polygon,
                requiresCategory: true,
                requiredReferences: [.building],
                categoryFeature: .footprint
            )
        case .level:
            .init(
                feature: self,
                geometry: .polygon,
                requiresCategory: true,
                requiredReferences: [.building],
                categoryFeature: .level
            )
        case .unit:
            .init(
                feature: self,
                geometry: .polygon,
                requiresCategory: true,
                requiredReferences: [.level],
                categoryFeature: .unit
            )
        case .opening:
            .init(
                feature: self,
                geometry: .line,
                requiresCategory: true,
                requiredReferences: [.level],
                categoryFeature: .opening
            )
        case .amenity:
            .init(
                feature: self,
                geometry: .point,
                requiresCategory: true,
                requiredReferences: [.unit],
                categoryFeature: .amenity
            )
        case .anchor:
            .init(feature: self, geometry: .point, requiredReferences: [.unit])
        case .occupant:
            .init(
                feature: self,
                geometry: .form,
                requiresCategory: true,
                requiredReferences: [.anchor],
                categoryFeature: .occupant
            )
        case .detail:
            .init(feature: self, geometry: .line, requiredReferences: [.level])
        case .fixture:
            .init(
                feature: self,
                geometry: .polygon,
                requiresCategory: true,
                requiredReferences: [.level],
                categoryFeature: .fixture
            )
        case .geofence:
            .init(
                feature: self,
                geometry: .polygon,
                requiresCategory: true,
                requiredReferences: [.levelOrBuilding],
                categoryFeature: .geofence
            )
        case .kiosk:
            .init(feature: self, geometry: .polygon, requiredReferences: [.level])
        case .relationship:
            .init(
                feature: self,
                geometry: .form,
                requiresCategory: true,
                requiredReferences: [.relationshipEndpoints],
                categoryFeature: .relationship
            )
        case .section:
            .init(
                feature: self,
                geometry: .polygon,
                requiresCategory: true,
                requiredReferences: [.level],
                categoryFeature: .section
            )
        }
    }
}

public struct IMDFAuthoringContract: Codable, Equatable, Sendable {
    public let feature: IMDFAuthoringFeature
    public let geometry: IMDFAuthoringGeometry
    public let requiresCategory: Bool
    public let requiredReferences: [IMDFAuthoringReference]
    public let categoryFeature: IMDFCategoryFeature?

    public init(
        feature: IMDFAuthoringFeature,
        geometry: IMDFAuthoringGeometry,
        requiresCategory: Bool = false,
        requiredReferences: [IMDFAuthoringReference] = [],
        categoryFeature: IMDFCategoryFeature? = nil
    ) {
        self.feature = feature
        self.geometry = geometry
        self.requiresCategory = requiresCategory
        self.requiredReferences = requiredReferences
        self.categoryFeature = categoryFeature
    }
}

@MainActor
@Observable
public final class FeatureAuthoringToolState {
    public private(set) var selectedFeature: IMDFAuthoringFeature
    public private(set) var draftedPointCount: Int
    public private(set) var hasSelectedCategory: Bool
    public private(set) var satisfiedReferences: Set<IMDFAuthoringReference>

    public init(
        selectedFeature: IMDFAuthoringFeature = .unit,
        draftedPointCount: Int = 0,
        hasSelectedCategory: Bool = false,
        satisfiedReferences: Set<IMDFAuthoringReference> = []
    ) {
        self.selectedFeature = selectedFeature
        self.draftedPointCount = draftedPointCount
        self.hasSelectedCategory = hasSelectedCategory
        self.satisfiedReferences = satisfiedReferences
    }

    public var contract: IMDFAuthoringContract {
        selectedFeature.contract
    }

    public var canFinish: Bool {
        hasEnoughGeometry && hasRequiredCategory && hasRequiredReferences
    }

    public var remainingPointCount: Int {
        max(0, contract.geometry.minimumPointCount - draftedPointCount)
    }

    public var isCategorySatisfied: Bool {
        hasRequiredCategory
    }

    public var missingReferences: [IMDFAuthoringReference] {
        contract.requiredReferences.filter { !satisfiedReferences.contains($0) }
    }

    public func selectFeature(_ feature: IMDFAuthoringFeature) {
        selectedFeature = feature
        resetDraft()
    }

    public func addDraftPoint() {
        draftedPointCount += 1
    }

    public func removeLastDraftPoint() {
        draftedPointCount = max(0, draftedPointCount - 1)
    }

    public func setCategorySelected(_ isSelected: Bool) {
        hasSelectedCategory = isSelected
    }

    public func satisfyReference(_ reference: IMDFAuthoringReference) {
        satisfiedReferences.insert(reference)
    }

    public func clearReference(_ reference: IMDFAuthoringReference) {
        satisfiedReferences.remove(reference)
    }

    public func satisfyRequiredReferences() {
        satisfiedReferences.formUnion(contract.requiredReferences)
    }

    public func cancel() {
        resetDraft()
    }

    private var hasEnoughGeometry: Bool {
        draftedPointCount >= contract.geometry.minimumPointCount
    }

    private var hasRequiredCategory: Bool {
        !contract.requiresCategory || hasSelectedCategory
    }

    private var hasRequiredReferences: Bool {
        Set(contract.requiredReferences).isSubset(of: satisfiedReferences)
    }

    private func resetDraft() {
        draftedPointCount = 0
        hasSelectedCategory = false
        satisfiedReferences = []
    }
}
