enum ProjectHomeWorkflowStep: CaseIterable, Identifiable {
    case locate
    case align
    case author
    case validate

    var id: Self { self }

    var title: String {
        switch self {
        case .locate: ProjectHomeText.locate
        case .align: ProjectHomeText.align
        case .author: ProjectHomeText.author
        case .validate: ProjectHomeText.validate
        }
    }

    var subtitle: String {
        switch self {
        case .locate: ProjectHomeText.locateSubtitle
        case .align: ProjectHomeText.alignSubtitle
        case .author: ProjectHomeText.authorSubtitle
        case .validate: ProjectHomeText.validateSubtitle
        }
    }

    var systemImage: String {
        switch self {
        case .locate: ProjectHomeSymbol.locate
        case .align: ProjectHomeSymbol.align
        case .author: ProjectHomeSymbol.author
        case .validate: ProjectHomeSymbol.validate
        }
    }
}
