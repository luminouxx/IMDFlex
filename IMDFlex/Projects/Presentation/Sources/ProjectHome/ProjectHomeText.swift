import Foundation

enum ProjectHomeText {
    static let navigationTitle = localized("projectHome.navigation.title", defaultValue: "Projects")
    static let heroTitle = localized("projectHome.hero.title", defaultValue: "Build indoor maps with confidence.")
    static let heroSubtitle = localized(
        "projectHome.hero.subtitle",
        defaultValue: "Create, validate, and export Apple IMDF projects from one focused workspace."
    )
    static let newProject = localized("projectHome.action.newProject", defaultValue: "New project")
    static let recentProjects = localized("projectHome.recent.title", defaultValue: "Recent projects")
    static let recentProjectsSubtitle = localized(
        "projectHome.recent.subtitle",
        defaultValue: "Continue from your most recently edited work."
    )
    static let workflow = localized("projectHome.workflow.title", defaultValue: "A clear path to IMDF")
    static let workflowSubtitle = localized(
        "projectHome.workflow.subtitle",
        defaultValue: "Each project follows the same map-first workflow."
    )
    static let locate = localized("projectHome.workflow.locate.title", defaultValue: "Locate")
    static let locateSubtitle = localized(
        "projectHome.workflow.locate.subtitle",
        defaultValue: "Lock the building on Apple Maps."
    )
    static let align = localized("projectHome.workflow.align.title", defaultValue: "Align")
    static let alignSubtitle = localized(
        "projectHome.workflow.align.subtitle",
        defaultValue: "Match each floor plan to the map."
    )
    static let author = localized("projectHome.workflow.author.title", defaultValue: "Author")
    static let authorSubtitle = localized(
        "projectHome.workflow.author.subtitle",
        defaultValue: "Draw and describe IMDF features."
    )
    static let validate = localized("projectHome.workflow.validate.title", defaultValue: "Validate")
    static let validateSubtitle = localized(
        "projectHome.workflow.validate.subtitle",
        defaultValue: "Resolve issues before export."
    )
    static let searchPrompt = localized("projectHome.search.prompt", defaultValue: "Search projects")
    static let noProjects = localized("projectHome.empty.title", defaultValue: "No projects yet")
    static let noProjectsMessage = localized(
        "projectHome.empty.message",
        defaultValue: "Create a project to start placing your venue on Apple Maps."
    )
    static let loadFailed = localized("projectHome.error.loading.title", defaultValue: "Projects couldn’t be loaded")
    static let loadFailedMessage = localized(
        "projectHome.error.loading.message",
        defaultValue: "Check the project files on this device, then try again."
    )
    static let creationFailed = localized(
        "projectHome.error.creation",
        defaultValue: "The project couldn’t be created. Try again."
    )
    static let deletionFailed = localized(
        "projectHome.error.deletion",
        defaultValue: "The project couldn’t be deleted. Your work is still available."
    )
    static let retry = localized("projectHome.action.retry", defaultValue: "Try again")
    static let lastUpdated = localized("projectHome.project.lastUpdated", defaultValue: "Last updated")
    static let projectActions = localized("projectHome.project.actions", defaultValue: "Project actions")
    static let openProject = localized("projectHome.action.open", defaultValue: "Open project")
    static let deleteProject = localized("projectHome.action.delete", defaultValue: "Delete project")
    static let deleteConfirmationTitle = localized(
        "projectHome.delete.title",
        defaultValue: "Delete this project?"
    )
    static let deleteConfirmationMessage = localized(
        "projectHome.delete.message",
        defaultValue: "This project will be removed from this device."
    )
    static let cancel = localized("projectHome.action.cancel", defaultValue: "Cancel")
    static let createTitle = localized("projectHome.create.title", defaultValue: "Create a project")
    static let projectName = localized("projectHome.create.name", defaultValue: "Project name")
    static let projectNamePlaceholder = localized(
        "projectHome.create.namePlaceholder",
        defaultValue: "e.g. Suwon Convention Center"
    )
    static let projectNameSupporting = localized(
        "projectHome.create.nameSupporting",
        defaultValue: "You can rename the project later."
    )
    static let invalidProjectName = localized(
        "projectHome.create.invalidName",
        defaultValue: "Enter a project name."
    )
    static let workspaceUnavailable = localized(
        "projectHome.workspace.unavailable.title",
        defaultValue: "Project unavailable"
    )
    static let workspaceUnavailableMessage = localized(
        "projectHome.workspace.unavailable.message",
        defaultValue: "Return to Projects and reload the project list."
    )

    private static func localized(
        _ key: StaticString,
        defaultValue: String.LocalizationValue
    ) -> String {
        String(
            localized: key,
            defaultValue: defaultValue,
            table: "ProjectHome",
            bundle: .imdfPresentation
        )
    }
}
