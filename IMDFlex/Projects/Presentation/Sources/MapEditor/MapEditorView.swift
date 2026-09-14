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

                    MapEditorInspector(state: authoringState)
                        .frame(width: 300)
                }

                Spacer(minLength: 0)

                MapEditorFeatureToolbar(state: authoringState)
            }
            .padding(IMDFSpacing.lg)
        }
        .navigationTitle(project.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Button(MapEditorText.export, systemImage: MapEditorSymbol.export) {}
                    Button(MapEditorText.settings, systemImage: MapEditorSymbol.settings) {}
                } label: {
                    Image(systemName: MapEditorSymbol.more)
                }
                .accessibilityLabel(MapEditorText.editorActions)
            }
        }
    }
}
