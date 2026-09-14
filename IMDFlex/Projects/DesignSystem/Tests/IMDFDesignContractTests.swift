import XCTest
import SwiftUI
import UIKit
@testable import DesignSystem

@MainActor
final class IMDFDesignContractTests: XCTestCase {
    func test_whenLayoutModesAreEnumerated_thenCompactIntermediateAndRegularAreAvailable() {
        // Given
        let sut = IMDFLayoutMode.allCases

        // When
        let modeCount = sut.count

        // Then
        XCTAssertEqual(modeCount, 3)
        XCTAssertEqual(sut, [.compact, .intermediate, .regular])
    }

    func test_whenLayoutModeChanges_thenContentPaddingUsesTheResponsiveScale() {
        // Given
        let compact = IMDFLayoutMode.compact
        let intermediate = IMDFLayoutMode.intermediate
        let regular = IMDFLayoutMode.regular

        // When
        let paddings = [compact.contentPadding, intermediate.contentPadding, regular.contentPadding]

        // Then
        XCTAssertEqual(paddings, [16, 24, 32])
    }

    func test_whenInspectorIsPresented_thenWidthMatchesTheActiveLayoutMode() {
        // Given
        let compact = IMDFLayoutMode.compact
        let intermediate = IMDFLayoutMode.intermediate
        let regular = IMDFLayoutMode.regular

        // When
        let widths = [compact.inspectorWidth, intermediate.inspectorWidth, regular.inspectorWidth]

        // Then
        XCTAssertNil(widths[0])
        XCTAssertEqual(widths[1], 320)
        XCTAssertEqual(widths[2], 360)
    }

    func test_whenReduceMotionIsRequested_thenSpatialMotionIsDisabled() {
        // Given
        let standard = IMDFMotionMode.standard
        let reduced = IMDFMotionMode.reduced

        // When
        let standardWithSystemReduction = standard.allowsSpatialMotion(systemReduceMotion: true)
        let explicitlyReduced = reduced.allowsSpatialMotion(systemReduceMotion: false)

        // Then
        XCTAssertFalse(standardWithSystemReduction)
        XCTAssertFalse(explicitlyReduced)
    }

    func test_whenStandardMotionIsAllowed_thenSpatialMotionRemainsEnabled() {
        // Given
        let sut = IMDFMotionMode.standard

        // When
        let allowsSpatialMotion = sut.allowsSpatialMotion(systemReduceMotion: false)

        // Then
        XCTAssertTrue(allowsSpatialMotion)
    }

    func test_whenInteractiveControlsUseDesignMetrics_thenMinimumHitSizeIsFortyFourPoints() {
        // Given
        let minimumHitSize = IMDFControlMetrics.minimumHitSize

        // When
        let fieldHeight = IMDFControlMetrics.fieldHeight
        let statusHeight = IMDFControlMetrics.statusHeight

        // Then
        XCTAssertEqual(minimumHitSize, 44)
        XCTAssertEqual(fieldHeight, minimumHitSize)
        XCTAssertEqual(statusHeight, 32)
    }

    func test_whenSurfacesUseDesignRadii_thenControlAndPanelHierarchyRemainsConsistent() {
        // Given
        let badgeRadius = IMDFRadius.badge
        let controlRadius = IMDFRadius.control

        // When
        let panelRadii = [IMDFRadius.compactPanel, IMDFRadius.panel]

        // Then
        XCTAssertEqual(badgeRadius, 8)
        XCTAssertEqual(controlRadius, 12)
        XCTAssertEqual(panelRadii, [16, 20])
    }

    func test_whenAccentColorResolvesInLightAppearance_thenItMatchesTheFoundationToken() {
        // Given
        let sut = resolvedComponents(
            of: IMDFColor.accent,
            traits: UITraitCollection(userInterfaceStyle: .light)
        )

        // When
        let expectedComponents: [CGFloat] = [0, 0.369, 0.659, 1]

        // Then
        XCTAssertEqual(sut.count, expectedComponents.count)
        for (component, expectedComponent) in zip(sut, expectedComponents) {
            XCTAssertEqual(component, expectedComponent, accuracy: 0.002)
        }
    }

    func test_whenSemanticColorsResolveAcrossAppearances_thenTextContrastMeetsWCAGAA() {
        // Given
        let semanticColors = [
            IMDFColor.accent,
            IMDFColor.success,
            IMDFColor.warning,
            IMDFColor.danger,
        ]
        let appearances = appearanceTraits

        // When
        let contrastRatios = appearances.flatMap { traits in
            semanticColors.map { color in
                contrastRatio(
                    foreground: color,
                    background: Color(uiColor: .systemBackground),
                    traits: traits
                )
            }
        }

        // Then
        XCTAssertTrue(contrastRatios.allSatisfy { $0 >= 4.5 })
    }

    func test_whenFilledActionColorsResolveAcrossAppearances_thenWhiteLabelContrastMeetsWCAGAA() {
        // Given
        let filledActionColors = [
            IMDFColor.accentFill,
            IMDFColor.accentFillPressed,
            IMDFColor.dangerFill,
            IMDFColor.dangerFillPressed,
        ]

        // When
        let contrastRatios = appearanceTraits.flatMap { traits in
            filledActionColors.map { color in
                contrastRatio(
                    foreground: .white,
                    background: color,
                    traits: traits
                )
            }
        }

        // Then
        XCTAssertTrue(contrastRatios.allSatisfy { $0 >= 4.5 })
    }

    func test_whenHighContrastAppearanceIsEnabled_thenSemanticAssetsUseDistinctValues() {
        // Given
        let standardTraits = UITraitCollection(userInterfaceStyle: .light)
        let highContrastTraits = UITraitCollection {
            $0.userInterfaceStyle = .light
            $0.accessibilityContrast = .high
        }
        let semanticColors = [
            IMDFColor.accent,
            IMDFColor.success,
            IMDFColor.warning,
            IMDFColor.danger,
            IMDFColor.accentFill,
            IMDFColor.accentFillPressed,
            IMDFColor.dangerFill,
            IMDFColor.dangerFillPressed,
        ]

        // When
        let resolvedPairs = semanticColors.map { color in
            (
                UIColor(color).resolvedColor(with: standardTraits),
                UIColor(color).resolvedColor(with: highContrastTraits)
            )
        }

        // Then
        XCTAssertTrue(resolvedPairs.allSatisfy { $0 != $1 })
    }

    func test_whenAccessibilityCopyIsResolved_thenCatalogKeysAreNotExposedToUsers() {
        // Given
        let values = [
            DesignSystemText.readOnly,
            DesignSystemText.complete,
            DesignSystemText.actionRequired,
            DesignSystemText.selected,
            DesignSystemText.notSelected,
            DesignSystemText.information,
            DesignSystemText.success,
            DesignSystemText.warning,
            DesignSystemText.error,
        ]

        // When
        let unresolvedValues = values.filter {
            $0.isEmpty || $0.hasPrefix("designSystem.")
        }

        // Then
        XCTAssertTrue(unresolvedValues.isEmpty)
    }

    private func resolvedComponents(
        of color: Color,
        traits: UITraitCollection
    ) -> [CGFloat] {
        let resolvedColor = UIColor(color).resolvedColor(with: traits)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        resolvedColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return [red, green, blue, alpha]
    }

    private func contrastRatio(
        foreground: Color,
        background: Color,
        traits: UITraitCollection
    ) -> CGFloat {
        let foregroundComponents = resolvedComponents(
            of: foreground,
            traits: traits
        )
        let backgroundComponents = resolvedComponents(
            of: background,
            traits: traits
        )
        let foregroundLuminance = relativeLuminance(of: foregroundComponents)
        let backgroundLuminance = relativeLuminance(of: backgroundComponents)
        let lighter = max(foregroundLuminance, backgroundLuminance)
        let darker = min(foregroundLuminance, backgroundLuminance)
        return (lighter + 0.05) / (darker + 0.05)
    }

    private var appearanceTraits: [UITraitCollection] {
        [
            UITraitCollection(userInterfaceStyle: .light),
            UITraitCollection(userInterfaceStyle: .dark),
            UITraitCollection {
                $0.userInterfaceStyle = .light
                $0.accessibilityContrast = .high
            },
            UITraitCollection {
                $0.userInterfaceStyle = .dark
                $0.accessibilityContrast = .high
            },
        ]
    }

    private func relativeLuminance(of components: [CGFloat]) -> CGFloat {
        let linearComponents = components.prefix(3).map { component in
            component <= 0.04045
                ? component / 12.92
                : pow((component + 0.055) / 1.055, 2.4)
        }
        return (0.2126 * linearComponents[0])
            + (0.7152 * linearComponents[1])
            + (0.0722 * linearComponents[2])
    }
}
