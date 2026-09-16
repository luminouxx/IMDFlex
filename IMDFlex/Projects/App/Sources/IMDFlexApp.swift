import SwiftUI
import Domain
import Data
import Presentation

@main
struct IMDFlexApp: App {
    private let projectRepository = ProjectRepository()
    
    var body: some Scene {
        WindowGroup {
            ProjectHomeView(
                service: ProjectUseCase(repository: projectRepository)
            )
        }
    }
}
