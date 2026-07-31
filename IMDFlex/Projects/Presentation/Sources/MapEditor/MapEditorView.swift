import DesignSystem
import Domain
import MapKit
import SwiftUI

public struct MapEditorView: View {
    @State private var viewModel: MapEditorViewModel

    public init(project: IMDFProject) {
        self._viewModel = State(initialValue: MapEditorViewModel(project: project))
    }

    public var body: some View {
        @Bindable var viewModel = viewModel

        ZStack {
            Map(position: $viewModel.cameraPosition)
                .mapStyle(.standard)
                .ignoresSafeArea(edges: .bottom)

            VStack(spacing: IMDFSpacing.md) {
                HStack(alignment: .top, spacing: IMDFSpacing.md) {
                    Spacer(minLength: 0)

                    AuthoringInspector(
                        selectedFeature: viewModel.selectedFeatureDescriptor,
                        geometry: viewModel.geometryDescriptor,
                        draftProgressText: viewModel.draftProgressText,
                        draftStatus: viewModel.draftStatus,
                        categoryRequirement: viewModel.categoryRequirement,
                        referenceRequirement: viewModel.referenceRequirement,
                        canAddDraftPoint: viewModel.canAddDraftPoint,
                        canRemoveDraftPoint: viewModel.canRemoveDraftPoint,
                        canFinishDraft: viewModel.canFinishDraft,
                        onToggleCategorySelection: viewModel.toggleCategorySelection,
                        onSatisfyRequiredReferences: viewModel.satisfyRequiredReferences,
                        onAddDraftPoint: viewModel.addDraftPoint,
                        onRemoveLastDraftPoint: viewModel.removeLastDraftPoint,
                        onCancelDraft: viewModel.cancelDraft,
                        onFinishDraft: {
                            viewModel.finishDraft()
                        }
                    )
                        .frame(width: 300)
                }

                Spacer(minLength: 0)

                AuthoringFeatureToolbar(
                    featureTools: viewModel.featureTools,
                    selectedFeature: viewModel.selectedFeature,
                    onSelectFeature: viewModel.selectFeature
                )
            }
            .padding(IMDFSpacing.lg)
        }
        .navigationTitle(viewModel.navigationTitle)
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
    let featureTools: [IMDFAuthoringFeatureDisplayDescriptor]
    let selectedFeature: IMDFAuthoringFeature
    let onSelectFeature: (IMDFAuthoringFeature) -> Void

    var body: some View {
        IMDFPanel(role: .floating) {
            ScrollView(.horizontal) {
                HStack(spacing: IMDFSpacing.sm) {
                    ForEach(featureTools) { feature in
                        IMDFToolButton(
                            title: feature.title,
                            systemImage: feature.systemImage,
                            isSelected: selectedFeature == feature.feature
                        ) {
                            onSelectFeature(feature.feature)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

private struct AuthoringInspector: View {
    let selectedFeature: IMDFAuthoringFeatureDisplayDescriptor
    let geometry: IMDFAuthoringGeometryDisplayDescriptor
    let draftProgressText: String
    let draftStatus: MapEditorDraftStatusDisplayState
    let categoryRequirement: MapEditorRequirementDisplayState?
    let referenceRequirement: MapEditorRequirementDisplayState
    let canAddDraftPoint: Bool
    let canRemoveDraftPoint: Bool
    let canFinishDraft: Bool
    let onToggleCategorySelection: () -> Void
    let onSatisfyRequiredReferences: () -> Void
    let onAddDraftPoint: () -> Void
    let onRemoveLastDraftPoint: () -> Void
    let onCancelDraft: () -> Void
    let onFinishDraft: () -> Void

    var body: some View {
        IMDFPanel(role: .inspector) {
            VStack(alignment: .leading, spacing: IMDFSpacing.lg) {
                IMDFInspectorSection(title: selectedFeature.title) {
                    IMDFInspectorRow(
                        title: "Geometry",
                        value: geometry.title,
                        systemImage: geometry.systemImage
                    )

                    IMDFInspectorRow(title: "Draft points", systemImage: "point.3.connected.trianglepath.dotted") {
                        Text(draftProgressText)
                    }

                    IMDFInspectorRow(title: "Status", systemImage: draftStatus.systemImage) {
                        IMDFStatusBadge(
                            draftStatus.title,
                            systemImage: draftStatus.systemImage,
                            role: draftStatus.isReady ? .success : .warning
                        )
                    }
                }

                RequirementSection(
                    categoryRequirement: categoryRequirement,
                    referenceRequirement: referenceRequirement,
                    onToggleCategorySelection: onToggleCategorySelection,
                    onSatisfyRequiredReferences: onSatisfyRequiredReferences
                )
                DraftControls(
                    canAddDraftPoint: canAddDraftPoint,
                    canRemoveDraftPoint: canRemoveDraftPoint,
                    canFinishDraft: canFinishDraft,
                    onAddDraftPoint: onAddDraftPoint,
                    onRemoveLastDraftPoint: onRemoveLastDraftPoint,
                    onCancelDraft: onCancelDraft,
                    onFinishDraft: onFinishDraft
                )
            }
        }
    }
}

private struct RequirementSection: View {
    let categoryRequirement: MapEditorRequirementDisplayState?
    let referenceRequirement: MapEditorRequirementDisplayState
    let onToggleCategorySelection: () -> Void
    let onSatisfyRequiredReferences: () -> Void

    var body: some View {
        IMDFInspectorSection(title: "Requirements") {
            if let categoryRequirement {
                Button {
                    onToggleCategorySelection()
                } label: {
                    requirementRow(
                        state: categoryRequirement
                    )
                }
                .buttonStyle(.plain)
            }

            if referenceRequirement.value == "None" {
                requirementRow(state: referenceRequirement)
            } else {
                Button {
                    onSatisfyRequiredReferences()
                } label: {
                    requirementRow(state: referenceRequirement)
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func requirementRow(state: MapEditorRequirementDisplayState) -> some View {
        HStack(spacing: IMDFSpacing.sm) {
            Image(systemName: state.isReady ? "checkmark.circle.fill" : "circle")
                .font(.system(size: IMDFIconSize.sm, weight: .semibold))
                .foregroundStyle(state.isReady ? IMDFColor.success : .secondary)

            Text(state.title)
                .font(IMDFFont.inspectorLabel)
                .foregroundStyle(.secondary)

            Spacer(minLength: IMDFSpacing.md)

            Text(state.value)
                .font(IMDFFont.inspectorValue)
                .lineLimit(1)
        }
        .frame(minHeight: 32)
        .accessibilityElement(children: .combine)
    }
}

private struct DraftControls: View {
    let canAddDraftPoint: Bool
    let canRemoveDraftPoint: Bool
    let canFinishDraft: Bool
    let onAddDraftPoint: () -> Void
    let onRemoveLastDraftPoint: () -> Void
    let onCancelDraft: () -> Void
    let onFinishDraft: () -> Void

    var body: some View {
        HStack(spacing: IMDFSpacing.sm) {
            IMDFToolButton(title: "Add point", systemImage: "plus") {
                onAddDraftPoint()
            }
            .disabled(!canAddDraftPoint)

            IMDFToolButton(title: "Remove point", systemImage: "minus") {
                onRemoveLastDraftPoint()
            }
            .disabled(!canRemoveDraftPoint)

            IMDFToolButton(title: "Cancel draft", systemImage: "xmark") {
                onCancelDraft()
            }

            IMDFToolButton(
                title: "Finish draft",
                systemImage: "checkmark",
                isSelected: canFinishDraft,
                role: .primary
            ) {
                onFinishDraft()
            }
            .disabled(!canFinishDraft)
        }
    }
}

#Preview("Map Editor") {
    NavigationStack {
        MapEditorView(project: IMDFProject(name: "IMDFlex Preview"))
    }
}
