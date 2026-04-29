import Foundation

enum DrinkCardCategory: String, CaseIterable, Codable, Identifiable {
    case spirit   = "Spirit"
    case wine     = "Wine"
    case beer     = "Beer"
    case barDrink = "Bar Find"
    case other    = "Other"

    var id: String { rawValue }

    var hasOriginMap: Bool {
        switch self {
        case .spirit, .wine, .beer: return true
        default: return false
        }
    }

    var symbol: String {
        switch self {
        case .spirit:   return "drop.fill"
        case .wine:     return "wineglass.fill"
        case .beer:     return "mug.fill"
        case .barDrink: return "mappin.circle.fill"
        case .other:    return "circle.fill"
        }
    }

    var accentHex: String {
        switch self {
        case .spirit:   return "C8A96E"
        case .wine:     return "9B3A5A"
        case .beer:     return "C87941"
        case .barDrink: return "4A7C8B"
        case .other:    return "5A5040"
        }
    }
}

struct DrinkCard: Identifiable, Codable {
    var id                      = UUID()
    var name: String
    var category: DrinkCardCategory
    var producer: String?
    var description: String?
    var origin: Origin?
    var vintage: Int?
    var abv: Double?
    var tastingNotes: [String]      = []
    var knownIngredients: [String]  = []
    var tags: [String]              = []
    var venueID: UUID?
    var venueName: String?
    var estimatedRecipe: Recipe?
    var isCheckedIn: Bool           = false
    var userRating: Int?
    var userNotes: String?
    var sourceURL: String?
    var createdAt: Date             = Date()
}
