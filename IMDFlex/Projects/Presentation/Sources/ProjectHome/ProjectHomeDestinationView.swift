import SwiftUI
import Domain

struct ProjectHomeDestinationView: View {
    let route: ProjectHomeRoute
    let projects: [IMDFProject]

    var body: some View {
        switch route {
        case .workspace(let projectID):
            if let project = projects.first(where: { $0.id == projectID }) {
                MapEditorView(project: project)
            } else {
                ContentUnavailableView(
                    ProjectHomeText.workspaceUnavailable,
                    systemImage: ProjectHomeSymbol.error,
                    description: Text(ProjectHomeText.workspaceUnavailableMessage)
                )
            }
        }
    }
}
