import DesignSystem
import Domain
import MapKit
import SwiftUI

public struct MapEditorView: View {
    let project: IMDFProject

    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var authoringState = FeatureAuthoringToolState()

    public init(project: IMDFProject) {
        self.project = project
    }

    public var body: some View {
        ZStack {
            Map(position: $cameraPosition)
                .mapStyle(.standard)
                .ignoresSafeArea(edges: .bottom)

            VStack(spacing: IMDFSpacing.md) {
                HStack(alignment: .top, spacing: IMDFSpacing.md) {
                    Spacer(minLength: 0)

                    AuthoringInspector(state: authoringState)
                        .frame(width: 300)
                }

                Spacer(minLength: 0)

                AuthoringFeatureToolbar(state: authoringState)
            }
            .padding(IMDFSpacing.lg)
        }
        .navigationTitle(project.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Button("Export", systemImage: "square.and.arrow.up") {}
                    Button("Settings", systemImage: "gear") {}
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
                .accessibilityLabel("Editor actions")
            }
        }
    }
}

private struct AuthoringFeatureToolbar: View {
    let state: FeatureAuthoringToolState

    var body: some View {
        IMDFPanel(role: .floating) {
            ScrollView(.horizontal) {
                HStack(spacing: IMDFSpacing.sm) {
                    ForEach(IMDFAuthoringFeature.allCases) { feature in
                        IMDFToolButton(
                            title: feature.title,
                            systemImage: feature.systemImage,
                            isSelected: state.selectedFeature == feature
                        ) {
                            state.selectFeature(feature)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

private struct AuthoringInspector: View {
    let state: FeatureAuthoringToolState

    var body: some View {
        IMDFPanel(role: .inspector) {
            VStack(alignment: .leading, spacing: IMDFSpacing.lg) {
                IMDFInspectorSection(title: state.selectedFeature.title) {
                    IMDFInspectorRow(
                        title: "Geometry",
                        value: state.contract.geometry.title,
                        systemImage: state.contract.geometry.systemImage
                    )

                    IMDFInspectorRow(title: "Draft points", systemImage: "point.3.connected.trianglepath.dotted") {
                        Text("\(state.draftedPointCount)/\(state.contract.geometry.minimumPointCount)")
                    }

                    IMDFInspectorRow(title: "Status", systemImage: state.canFinish ? "checkmark.circle" : "clock") {
                        IMDFStatusBadge(
                            state.canFinish ? "Ready" : "Draft",
                            systemImage: state.canFinish ? "checkmark.circle" : "clock",
                            role: state.canFinish ? .success : .warning
                        )
                    }
                }

                RequirementSection(state: state)
                DraftControls(state: state)
            }
        }
    }
}

private struct RequirementSection: View {
    let state: FeatureAuthoringToolState

    var body: some View {
        IMDFInspectorSection(title: "Requirements") {
            if state.contract.requiresCategory {
                Button {
                    state.setCategorySelected(!state.hasSelectedCategory)
                } label: {
                    requirementRow(
                        title: "Category",
                        value: state.hasSelectedCategory ? "Selected" : "Required",
                        isReady: state.hasSelectedCategory
                    )
                }
                .buttonStyle(.plain)
            }

            if state.contract.requiredReferences.isEmpty {
                requirementRow(title: "References", value: "None", isReady: true)
            } else {
                Button {
                    state.satisfyRequiredReferences()
                } label: {
                    requirementRow(
                        title: "References",
                        value: state.missingReferences.isEmpty ? "Linked" : state.missingReferences.map(\.title).joined(separator: ", "),
                        isReady: state.missingReferences.isEmpty
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func requirementRow(title: String, value: String, isReady: Bool) -> some View {
        HStack(spacing: IMDFSpacing.sm) {
            Image(systemName: isReady ? "checkmark.circle.fill" : "circle")
                .font(.system(size: IMDFIconSize.sm, weight: .semibold))
                .foregroundStyle(isReady ? IMDFColor.success : .secondary)

            Text(title)
                .font(IMDFFont.inspectorLabel)
                .foregroundStyle(.secondary)

            Spacer(minLength: IMDFSpacing.md)

            Text(value)
                .font(IMDFFont.inspectorValue)
                .lineLimit(1)
        }
        .frame(minHeight: 32)
        .accessibilityElement(children: .combine)
    }
}

private struct DraftControls: View {
    let state: FeatureAuthoringToolState

    var body: some View {
        HStack(spacing: IMDFSpacing.sm) {
            IMDFToolButton(title: "Add point", systemImage: "plus") {
                state.addDraftPoint()
            }
            .disabled(state.contract.geometry == .form)

            IMDFToolButton(title: "Remove point", systemImage: "minus") {
                state.removeLastDraftPoint()
            }
            .disabled(state.draftedPointCount == 0)

            IMDFToolButton(title: "Cancel draft", systemImage: "xmark") {
                state.cancel()
            }

            IMDFToolButton(
                title: "Finish draft",
                systemImage: "checkmark",
                isSelected: state.canFinish,
                role: .primary
            ) {}
            .disabled(!state.canFinish)
        }
    }
}

private extension IMDFAuthoringFeature {
    var title: String {
        switch self {
        case .address: "Address"
        case .venue: "Venue"
        case .building: "Building"
        case .footprint: "Footprint"
        case .level: "Level"
        case .unit: "Unit"
        case .opening: "Opening"
        case .amenity: "Amenity"
        case .anchor: "Anchor"
        case .occupant: "Occupant"
        case .detail: "Detail"
        case .fixture: "Fixture"
        case .geofence: "Geofence"
        case .kiosk: "Kiosk"
        case .relationship: "Relationship"
        case .section: "Section"
        }
    }

    var systemImage: String {
        switch self {
        case .address: "mappin.and.ellipse"
        case .venue: "map"
        case .building: "building.2"
        case .footprint: "skew"
        case .level: "square.stack.3d.up"
        case .unit: "square.split.2x2"
        case .opening: "door.left.hand.open"
        case .amenity: "fork.knife"
        case .anchor: "pin"
        case .occupant: "person.crop.square"
        case .detail: "line.diagonal"
        case .fixture: "table.furniture"
        case .geofence: "location.viewfinder"
        case .kiosk: "display"
        case .relationship: "point.3.connected.trianglepath.dotted"
        case .section: "rectangle.3.group"
        }
    }
}

private extension IMDFAuthoringGeometry {
    var title: String {
        switch self {
        case .point: "Point"
        case .line: "Line"
        case .polygon: "Polygon"
        case .form: "Form"
        }
    }

    var systemImage: String {
        switch self {
        case .point: "smallcircle.filled.circle"
        case .line: "line.diagonal"
        case .polygon: "skew"
        case .form: "list.bullet.rectangle"
        }
    }
}

private extension IMDFAuthoringReference {
    var title: String {
        switch self {
        case .building: "Building"
        case .level: "Level"
        case .unit: "Unit"
        case .anchor: "Anchor"
        case .levelOrBuilding: "Level or building"
        case .relationshipEndpoints: "Endpoints"
        }
    }
}
