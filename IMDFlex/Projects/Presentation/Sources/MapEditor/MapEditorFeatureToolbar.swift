import DesignSystem
import SwiftUI

struct MapEditorFeatureToolbar: View {
    let state: FeatureAuthoringToolState

    var body: some View {
        IMDFPanel {
            ScrollView(.horizontal) {
                HStack(spacing: IMDFSpacing.sm) {
                    ForEach(IMDFAuthoringFeature.allCases) { feature in
                        IMDFToolButton(
                            feature.title,
                            systemImage: feature.systemImage
                        ) {
                            state.selectFeature(feature)
                        }
                        .selected(state.selectedFeature == feature)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}
