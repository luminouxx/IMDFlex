import SwiftUI
import DesignSystem

struct ProjectHomeHeader: View {
    @Environment(\.imdfLayoutMode) private var layoutMode
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    let onCreateProject: () -> Void

    var body: some View {
        let usesVerticalLayout = layoutMode == .compact || dynamicTypeSize.isAccessibilitySize
        let headerLayout = usesVerticalLayout
            ? AnyLayout(VStackLayout(alignment: .leading, spacing: IMDFSpacing.xl))
            : AnyLayout(HStackLayout(alignment: .bottom, spacing: IMDFSpacing.xl))

        headerLayout {
            VStack(alignment: .leading, spacing: IMDFSpacing.md) {
                Image(systemName: ProjectHomeSymbol.project)
                    .font(.title2)
                    .foregroundStyle(IMDFColor.accent)
                    .frame(width: 48, height: 48)
                    .background(IMDFColor.selectedFill)
                    .clipShape(.rect(cornerRadius: IMDFRadius.control))
                    .accessibilityHidden(true)

                Text(ProjectHomeText.heroTitle)
                    .font(.largeTitle)
                    .bold()
                    .tracking(-0.8)
                    .fixedSize(horizontal: false, vertical: true)

                Text(ProjectHomeText.heroSubtitle)
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: 680, alignment: .leading)
            }

            Spacer(minLength: IMDFSpacing.lg)

            Button(
                ProjectHomeText.newProject,
                systemImage: ProjectHomeSymbol.add,
                action: onCreateProject
            )
            .buttonStyle(.imdfPrimary)
            .controlSize(.large)
            .frame(maxWidth: usesVerticalLayout ? .infinity : nil)
        }
        .padding(.vertical, IMDFSpacing.xl)
    }
}
