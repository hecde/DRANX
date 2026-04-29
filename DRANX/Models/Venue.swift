import Foundation

struct Venue: Identifiable, Codable {
    var id          = UUID()
    var name: String
    var city: String?
    var state: String?
    var country: String         = "US"
    var menuSourceURL: String?
    var notes: String?
    var createdAt: Date         = Date()

    var displayLocation: String {
        [city, state].compactMap { $0 }.joined(separator: ", ")
    }
}
