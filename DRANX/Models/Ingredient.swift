import Foundation

enum MeasurementUnit: String, CaseIterable, Codable, Identifiable {
    // Volume
    case ounce      = "oz"
    case milliliter = "ml"
    case centiliter = "cl"
    case teaspoon   = "tsp"
    case tablespoon = "tbsp"
    case cup        = "cup"
    case dash       = "dash"
    case splash     = "splash"
    case drop       = "drop"
    case part       = "part"
    case barspoon   = "bsp"
    // Weight
    case gram       = "g"
    case kilogram   = "kg"
    case pound      = "lb"
    // Count / garnish
    case whole      = "whole"
    case slice      = "slice"
    case piece      = "piece"
    case pinch      = "pinch"
    case leaf       = "leaf"
    case sprig      = "sprig"
    case clove      = "clove"
    case wedge      = "wedge"
    case twist      = "twist"
    // Qualitative
    case toTaste    = "to taste"
    case asNeeded   = "as needed"

    var id: String { rawValue }

    var usesQuantity: Bool { category != .qualitative }

    var category: UnitCategory {
        switch self {
        case .ounce, .milliliter, .centiliter, .teaspoon, .tablespoon,
             .cup, .dash, .splash, .drop, .part, .barspoon:       return .volume
        case .gram, .kilogram, .pound:                             return .weight
        case .whole, .slice, .piece, .pinch, .leaf, .sprig,
             .clove, .wedge, .twist:                               return .count
        case .toTaste, .asNeeded:                                  return .qualitative
        }
    }

    enum UnitCategory: String, CaseIterable, Identifiable {
        case volume      = "Volume"
        case weight      = "Weight"
        case count       = "Count"
        case qualitative = "Qualitative"
        var id: String { rawValue }
    }
}

struct Ingredient: Identifiable, Codable {
    var id           = UUID()
    var name: String
    var quantity: Double?          = nil
    var unit: MeasurementUnit
    var isOptional: Bool           = false
    var substitutions: [String]    = []
    var notes: String?             = nil

    var formattedQuantity: String {
        guard let qty = quantity, unit.usesQuantity else { return "" }
        let whole    = Int(qty)
        let fraction = qty - Double(whole)
        let fStr: String
        switch fraction {
        case _ where abs(fraction - 0.25)     < 0.01: fStr = "¼"
        case _ where abs(fraction - 0.5)      < 0.01: fStr = "½"
        case _ where abs(fraction - 0.75)     < 0.01: fStr = "¾"
        case _ where abs(fraction - 1.0 / 3)  < 0.01: fStr = "⅓"
        case _ where abs(fraction - 2.0 / 3)  < 0.01: fStr = "⅔"
        case 0: fStr = ""
        default: return String(format: "%.2g", qty)
        }
        if whole == 0 { return fStr }
        return fStr.isEmpty ? "\(whole)" : "\(whole)\(fStr)"
    }
}
