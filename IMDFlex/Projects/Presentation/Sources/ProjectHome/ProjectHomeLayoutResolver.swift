import CoreGraphics
import DesignSystem

enum ProjectHomeLayoutResolver {
    static func mode(for width: CGFloat) -> IMDFLayoutMode {
        if width < 700 {
            .compact
        } else if width < 1_050 {
            .intermediate
        } else {
            .regular
        }
    }
}
