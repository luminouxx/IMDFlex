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
        NavigationStack {
            Group {
                if projects.isEmpty {
                    EmptyStateView(
                        title: "프로젝트 없음",
                        message: "새 프로젝트를 만들어 실내 지도를 생성하세요",
                        systemImage: "map"
                    )
                } else {
                    List {
                        ForEach(projects) { project in
                            NavigationLink(value: project) {
                                ProjectRow(project: project)
                            }
                        }
                        .onDelete(perform: deleteProjects)
                    }
                }
            }
            .navigationTitle("IMDFlex")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingNewProject = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(for: IMDFProject.self) { project in
                MapEditorView(project: project)
            }
            .alert("새 프로젝트", isPresented: $showingNewProject) {
                TextField("프로젝트 이름", text: $newProjectName)
                Button("취소", role: .cancel) {
                    newProjectName = ""
                }
                Button("생성") {
                    Task { await createProject() }
                }
            }
            .task {
                await loadProjects()
            }
        }
    }
    
    private func loadProjects() async {
        do {
            projects = try await useCase.loadProjects()
        } catch {
            print("Failed to load projects: \(error)")
        }
    }
    
    private func createProject() async {
        guard !newProjectName.isEmpty else { return }
        do {
            let project = try await useCase.createProject(name: newProjectName)
            projects.insert(project, at: 0)
            newProjectName = ""
        } catch {
            print("Failed to create project: \(error)")
        }
    }
    
    private func deleteProjects(at offsets: IndexSet) {
        Task {
            for index in offsets {
                let project = projects[index]
                try? await useCase.deleteProject(id: project.id)
            }
            projects.remove(atOffsets: offsets)
        }
    }
}

struct ProjectRow: View {
    let project: IMDFProject
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(project.name)
                .font(.headline)
            Text(project.updatedAt, style: .relative)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}
