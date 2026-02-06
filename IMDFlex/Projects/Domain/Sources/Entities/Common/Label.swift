//
//  Label.swift
//  Domain
//

import Foundation

/// Localized string dictionary
/// - Key: BCP 47 language tag (e.g., "en", "ko", "ja")
/// - Value: Localized string
///
/// Example:
/// ```swift
/// let name: Label = ["en": "Airport", "ko": "공항"]
/// ```
public typealias Label = [String: String]
