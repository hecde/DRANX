import Foundation

enum RecipeCategory: String, CaseIterable, Codable, Identifiable {
    case cocktail   = "Cocktail"
    case mocktail   = "Mocktail"
    case shot       = "Shot"
    case wine       = "Wine"
    case beer       = "Beer"
    case hotDrink   = "Hot Drink"
    case appetizer  = "Appetizer"
    case mainCourse = "Main Course"
    case dessert    = "Dessert"
    case side       = "Side"

    var id: String { rawValue }

    var isDrink: Bool {
        switch self {
        case .cocktail, .mocktail, .shot, .wine, .beer, .hotDrink: return true
        default: return false
        }
    }

    var symbol: String {
        switch self {
        case .cocktail:   return "wineglass"
        case .mocktail:   return "cup.and.saucer"
        case .shot:       return "square.fill"
        case .wine:       return "wineglass.fill"
        case .beer:       return "mug"
        case .hotDrink:   return "mug.fill"
        case .appetizer:  return "fork.knife"
        case .mainCourse: return "fork.knife.circle"
        case .dessert:    return "birthday.cake"
        case .side:       return "oval.portrait"
        }
    }
}

struct Recipe: Identifiable, Codable {
    var id              = UUID()
    var name: String
    var category: RecipeCategory
    var description: String?       = nil
    var ingredients: [Ingredient]
    var steps: [String]
    var glassware: String?         = nil
    var prepTimeMinutes: Int?      = nil
    var tags: [String]             = []
    var isUserCreated: Bool        = false
    var createdAt: Date            = Date()
}
