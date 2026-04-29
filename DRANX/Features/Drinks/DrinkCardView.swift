import SwiftUI

struct DrinkCardView: View {
    let card: DrinkCard

    private var accentColor: Color { Color(hex: card.category.accentHex) }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top row: category badge + origin
            HStack(alignment: .center) {
                DrinkCategoryBadge(category: card.category)
                Spacer()
                if let origin = card.origin {
                    HStack(spacing: 4) {
                        Image(systemName: "mappin.circle")
                            .imageScale(.small)
                        Text(origin.shortDisplay)
                    }
                    .font(.caption)
                    .foregroundStyle(Color.Speakeasy.parchment)
                }
                if card.isCheckedIn {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(accentColor)
                        .imageScale(.small)
                }
            }
            .padding(.bottom, 8)

            // Name
            Text(card.name)
                .font(.recipeTitle)
                .foregroundStyle(Color.Speakeasy.cream)

            // Producer
            if let producer = card.producer {
                Text(producer)
                    .font(.caption)
                    .foregroundStyle(Color.Speakeasy.parchment)
                    .padding(.top, 2)
            }

            // Venue for bar finds
            if card.category == .barDrink, let venue = card.venueName {
                HStack(spacing: 4) {
                    Image(systemName: "building.2")
                        .imageScale(.small)
                    Text(venue)
                }
                .font(.caption)
                .foregroundStyle(Color.Speakeasy.parchment)
                .padding(.top, 2)
            }

            // Tasting notes or known ingredients
            if !card.tastingNotes.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(card.tastingNotes.prefix(5), id: \.self) { note in
                            Text(note)
                                .font(.badgeText)
                                .foregroundStyle(accentColor)
                                .padding(.horizontal, 7)
                                .padding(.vertical, 3)
                                .background(accentColor.opacity(0.12))
                                .clipShape(Capsule())
                        }
                    }
                }
                .padding(.top, 10)
            } else if !card.knownIngredients.isEmpty {
                Text(card.knownIngredients.joined(separator: "  ·  "))
                    .font(.caption)
                    .foregroundStyle(Color.Speakeasy.parchment)
                    .lineLimit(1)
                    .padding(.top, 10)
            }

            // ABV + vintage
            HStack(spacing: 10) {
                Spacer()
                if let vintage = card.vintage {
                    Text("\(vintage)")
                        .font(.badgeText)
                        .foregroundStyle(Color.Speakeasy.ash)
                }
                if let abv = card.abv {
                    Text(String(format: "%.1f%% ABV", abv))
                        .font(.badgeText)
                        .foregroundStyle(Color.Speakeasy.ash)
                }
            }
            .padding(.top, 10)
        }
        .padding(16)
        .background(Color.Speakeasy.surfaceRaised)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(accentColor.opacity(0.25), lineWidth: 0.5)
        )
    }
}

struct DrinkCategoryBadge: View {
    let category: DrinkCardCategory

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: category.symbol)
                .imageScale(.small)
            Text(category.rawValue.uppercased())
        }
        .font(.badgeText)
        .foregroundStyle(Color(hex: category.accentHex))
        .padding(.horizontal, 8)
        .padding(.vertical, 3)
        .background(Color(hex: category.accentHex).opacity(0.15))
        .clipShape(Capsule())
    }
}

#Preview {
    ZStack {
        Color.Speakeasy.background.ignoresSafeArea()
        VStack(spacing: 12) {
            DrinkCardView(card: DrinkSampleData.makersMark)
            DrinkCardView(card: DrinkSampleData.caymusCab)
            DrinkCardView(card: DrinkSampleData.rusteakMule)
        }
        .padding()
    }
}
