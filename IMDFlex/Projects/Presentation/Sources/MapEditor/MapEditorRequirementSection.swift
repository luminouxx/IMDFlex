import DesignSystem
import SwiftUI

struct MapEditorRequirementSection: View {
    let state: FeatureAuthoringToolState

    var body: some View {
        IMDFInspectorSection(title: MapEditorText.requirements) {
            if state.contract.requiresCategory {
                IMDFInspectorActionRow(MapEditorText.category) {
                    state.setCategorySelected(!state.hasSelectedCategory)
                }
                .value(state.hasSelectedCategory ? MapEditorText.selected : MapEditorText.required)
                .complete(state.hasSelectedCategory)
            }

            if state.contract.requiredReferences.isEmpty {
                IMDFInspectorRow(MapEditorText.references, value: MapEditorText.none)
                    .systemImage(MapEditorSymbol.readyFilled)
            } else {
                IMDFInspectorActionRow(MapEditorText.references) {
                    state.satisfyRequiredReferences()
                }
                .value(
                    state.missingReferences.isEmpty
                        ? MapEditorText.linked
                        : MapEditorText.referenceList(state.missingReferences.map(\.title))
                )
                .complete(state.missingReferences.isEmpty)
            }
        }
    }
}
