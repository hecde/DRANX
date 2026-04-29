import SwiftUI

extension Color {
    enum Speakeasy {
        static let background    = Color(hex: "0E0B08")
        static let surface       = Color(hex: "1C1712")
        static let surfaceRaised = Color(hex: "2C2419")
        static let border        = Color(hex: "3A3025")
        static let gold          = Color(hex: "C8A96E")
        static let goldMuted     = Color(hex: "7A5C1E")
        static let cream         = Color(hex: "F2E8D5")
        static let parchment     = Color(hex: "9E8E72")
        static let ash           = Color(hex: "5A5040")
        static let positive      = Color(hex: "5E7A52")
        static let destructive   = Color(hex: "8B3A34")
    }

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:  (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:  (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:  (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 255, 255, 255)
        }
        self.init(.sRGB,
                  red:     Double(r) / 255,
                  green:   Double(g) / 255,
                  blue:    Double(b) / 255,
                  opacity: Double(a) / 255)
    }
}
