import SwiftUI
import Domain
import DesignSystem

public struct ProjectListView: View {
    @State private var projects: [IMDFProject] = []
    @State private var showingNewProject = false
    @State private var newProjectName = ""
    
    private let useCase: ProjectUseCase
    
    public init(useCase: ProjectUseCase) {
        self.useCase = useCase
    }
    
    public var body: some View {
        NavigationView {
            Text("examples")
        }
    }
}
