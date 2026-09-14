import DesignSystem
import SwiftUI

struct MapEditorInspector: View {
    let state: FeatureAuthoringToolState

    var body: some View {
        IMDFPanel {
            VStack(alignment: .leading, spacing: IMDFSpacing.lg) {
                IMDFInspectorSection(title: state.selectedFeature.title) {
                    IMDFInspectorRow(
                        MapEditorText.geometry,
                        value: state.contract.geometry.title
                    )
                    .systemImage(state.contract.geometry.systemImage)

                    IMDFInspectorRow(MapEditorText.draftPoints) {
                        Text(
                            MapEditorText.draftProgress(
                                current: state.draftedPointCount,
                                required: state.contract.geometry.minimumPointCount
                            )
                        )
                    }
                    .systemImage(MapEditorSymbol.draftPoints)

                    IMDFInspectorRow(MapEditorText.status) {
                        IMDFStatusBadge(state.canFinish ? MapEditorText.ready : MapEditorText.draft)
                            .status(state.canFinish ? .success : .warning)
                            .statusIcon(state.canFinish ? MapEditorSymbol.readyFilled : MapEditorSymbol.draftFilled)
                    }
                    .systemImage(state.canFinish ? MapEditorSymbol.ready : MapEditorSymbol.draft)
                }

                MapEditorRequirementSection(state: state)
                MapEditorDraftControls(state: state)
            }
        }
        .imdfPanelStyle(.inspector)
    }
}
