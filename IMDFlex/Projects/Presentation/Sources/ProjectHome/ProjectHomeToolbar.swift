import SwiftUI

struct ProjectHomeToolbar: ToolbarContent {
    let onCreateProject: () -> Void

    var body: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button(
                ProjectHomeText.newProject,
                systemImage: ProjectHomeSymbol.add,
                action: onCreateProject
            )
        }
    }
}
