import SwiftUI
import DesignSystem

public struct ProjectHomeView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var viewModel: ProjectHomeViewModel
    @State private var navigationPath: [ProjectHomeRoute] = []
    @State private var isPresentingCreateProject = false
    @State private var layoutMode: IMDFLayoutMode = .regular

    public init(service: any ProjectHomeServicing) {
        _viewModel = State(initialValue: ProjectHomeViewModel(service: service))
    }

    public var body: some View {
        @Bindable var bindableViewModel = viewModel

        NavigationStack(path: $navigationPath) {
            ProjectHomeContent(
                projects: viewModel.filteredProjects,
                hasStoredProjects: !viewModel.projects.isEmpty,
                loadState: viewModel.loadState,
                alert: viewModel.alert,
                isFiltering: viewModel.isFilteringProjects,
                onCreateProject: presentCreateProject,
                onOpenProject: openProject,
                onDeleteProject: deleteProject,
                onRetry: retryLoading
            )
            .navigationTitle(ProjectHomeText.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $bindableViewModel.searchQuery,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: ProjectHomeText.searchPrompt
            )
            .toolbar {
                ProjectHomeToolbar(onCreateProject: presentCreateProject)
            }
            .navigationDestination(for: ProjectHomeRoute.self) { route in
                ProjectHomeDestinationView(
                    route: route,
                    projects: viewModel.projects
                )
            }
            .sheet(isPresented: $isPresentingCreateProject) {
                CreateProjectSheet(
                    projectName: $bindableViewModel.newProjectName,
                    canCreateProject: viewModel.canCreateProject,
                    isCreatingProject: viewModel.isCreatingProject,
                    alert: viewModel.alert,
                    onCreateProject: createProject
                )
            }
            .task {
                await viewModel.loadIfNeeded()
            }
            .onGeometryChange(for: IMDFLayoutMode.self) { proxy in
                ProjectHomeLayoutResolver.mode(for: proxy.size.width)
            } action: { newLayoutMode in
                layoutMode = newLayoutMode
            }
        }
        .imdfLayoutMode(layoutMode)
        .imdfMotionMode(reduceMotion ? .reduced : .standard)
    }

    private func presentCreateProject() {
        isPresentingCreateProject = true
    }

    private func retryLoading() async {
        await viewModel.retryLoading()
    }

    private func createProject() async -> Bool {
        await viewModel.createProject()

        guard let route = viewModel.route else {
            return false
        }

        navigationPath.append(route)
        return true
    }

    private func openProject(projectID: UUID) {
        viewModel.openProject(projectID: projectID)
        navigationPath.append(.workspace(projectID: projectID))
    }

    private func deleteProject(projectID: UUID) async {
        viewModel.requestDeletion(projectID: projectID)
        await viewModel.confirmDeletion()
    }
}
