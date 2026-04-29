import SwiftUI

extension Font {
    static let heroTitle      = Font.system(.largeTitle,  design: .serif,      weight: .semibold)
    static let recipeTitle    = Font.system(.title2,      design: .serif,      weight: .semibold)
    static let sectionLabel   = Font.system(.caption,     design: .default,    weight: .semibold)
    static let measurement    = Font.system(.callout,     design: .monospaced, weight: .semibold)
    static let unitLabel      = Font.system(.caption,     design: .monospaced, weight: .regular)
    static let ingredientName = Font.system(.body,        design: .default,    weight: .regular)
    static let badgeText      = Font.system(.caption2,    design: .default,    weight: .semibold)
    static let stepText       = Font.system(.callout,     design: .default,    weight: .regular)
}
