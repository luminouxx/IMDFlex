import DesignSystem
import Domain
import MapKit
import SwiftUI

public struct MapEditorView: View {
    let project: IMDFProject

    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var viewModel = MapEditorViewModel()

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

                    AuthoringInspector(viewModel: viewModel)
                        .frame(width: 300)
                }

                Spacer(minLength: 0)

                AuthoringFeatureToolbar(viewModel: viewModel)
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
    let viewModel: MapEditorViewModel

    var body: some View {
        IMDFPanel(role: .floating) {
            ScrollView(.horizontal) {
                HStack(spacing: IMDFSpacing.sm) {
                    ForEach(viewModel.featureTools) { feature in
                        IMDFToolButton(
                            title: feature.title,
                            systemImage: feature.systemImage,
                            isSelected: viewModel.selectedFeature == feature.feature
                        ) {
                            viewModel.selectFeature(feature.feature)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

private struct AuthoringInspector: View {
    let viewModel: MapEditorViewModel

    var body: some View {
        IMDFPanel(role: .inspector) {
            VStack(alignment: .leading, spacing: IMDFSpacing.lg) {
                IMDFInspectorSection(title: viewModel.selectedFeatureDescriptor.title) {
                    IMDFInspectorRow(
                        title: "Geometry",
                        value: viewModel.geometryDescriptor.title,
                        systemImage: viewModel.geometryDescriptor.systemImage
                    )

                    IMDFInspectorRow(title: "Draft points", systemImage: "point.3.connected.trianglepath.dotted") {
                        Text(viewModel.draftProgressText)
                    }

                    IMDFInspectorRow(title: "Status", systemImage: viewModel.draftStatus.systemImage) {
                        IMDFStatusBadge(
                            viewModel.draftStatus.title,
                            systemImage: viewModel.draftStatus.systemImage,
                            role: viewModel.draftStatus.isReady ? .success : .warning
                        )
                    }
                }

                RequirementSection(viewModel: viewModel)
                DraftControls(viewModel: viewModel)
            }
        }
    }
}

private struct RequirementSection: View {
    let viewModel: MapEditorViewModel

    var body: some View {
        IMDFInspectorSection(title: "Requirements") {
            if let categoryRequirement = viewModel.categoryRequirement {
                Button {
                    viewModel.toggleCategorySelection()
                } label: {
                    requirementRow(
                        state: categoryRequirement
                    )
                }
                .buttonStyle(.plain)
            }

            if viewModel.referenceRequirement.value == "None" {
                requirementRow(state: viewModel.referenceRequirement)
            } else {
                Button {
                    viewModel.satisfyRequiredReferences()
                } label: {
                    requirementRow(state: viewModel.referenceRequirement)
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
    let viewModel: MapEditorViewModel

    var body: some View {
        HStack(spacing: IMDFSpacing.sm) {
            IMDFToolButton(title: "Add point", systemImage: "plus") {
                viewModel.addDraftPoint()
            }
            .disabled(!viewModel.canAddDraftPoint)

            IMDFToolButton(title: "Remove point", systemImage: "minus") {
                viewModel.removeLastDraftPoint()
            }
            .disabled(!viewModel.canRemoveDraftPoint)

            IMDFToolButton(title: "Cancel draft", systemImage: "xmark") {
                viewModel.cancelDraft()
            }

            IMDFToolButton(
                title: "Finish draft",
                systemImage: "checkmark",
                isSelected: viewModel.canFinishDraft,
                role: .primary
            ) {
                viewModel.finishDraft()
            }
            .disabled(!viewModel.canFinishDraft)
        }
    }
}
