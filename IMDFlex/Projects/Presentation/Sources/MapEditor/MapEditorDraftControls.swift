import DesignSystem
import SwiftUI

struct MapEditorDraftControls: View {
    let state: FeatureAuthoringToolState

    var body: some View {
        HStack(spacing: IMDFSpacing.sm) {
            IMDFToolButton(MapEditorText.addPoint, systemImage: MapEditorSymbol.add) {
                state.addDraftPoint()
            }
            .disabled(state.contract.geometry == .form)

            IMDFToolButton(MapEditorText.removePoint, systemImage: MapEditorSymbol.remove) {
                state.removeLastDraftPoint()
            }
            .disabled(state.draftedPointCount == 0)

            IMDFToolButton(MapEditorText.cancelDraft, systemImage: MapEditorSymbol.cancel) {
                state.cancel()
            }

            IMDFToolButton(
                MapEditorText.finishDraft,
                systemImage: MapEditorSymbol.finish
            ) {
                _ = state.finishDrawingDraft()
            }
            .role(.primary)
            .disabled(!state.canFinish)
        }
    }
}
