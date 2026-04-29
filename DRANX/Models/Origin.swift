import Foundation
import CoreLocation

struct Origin: Codable {
    var country: String
    var region: String?
    var locality: String?

    var latitude: Double?
    var longitude: Double?

    var coordinate: CLLocationCoordinate2D? {
        guard let lat = latitude, let lon = longitude else { return nil }
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }

    var displayName: String {
        [locality, region, country].compactMap { $0 }.joined(separator: ", ")
    }

    var shortDisplay: String {
        [locality ?? region, country].compactMap { $0 }.joined(separator: ", ")
    }
}
