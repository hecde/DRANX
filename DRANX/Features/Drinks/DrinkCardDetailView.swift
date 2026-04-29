import SwiftUI

struct DrinkCardDetailView: View {
    @Binding var card: DrinkCard

    private var accentColor: Color { Color(hex: card.category.accentHex) }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {

                // Map — spirits, wine, beer, and bar finds with a coordinate
                if card.category.hasOriginMap || card.origin?.coordinate != nil,
                   let origin = card.origin {
                    OriginMapView(origin: origin)
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                        .padding(.bottom, 20)
                }

                VStack(alignment: .leading, spacing: 20) {

                    // Meta badges
                    metaBadges

                    divider

                    // Description
                    if let desc = card.description {
                        Text(desc)
                            .font(.callout)
                            .foregroundStyle(Color.Speakeasy.parchment)
                            .fixedSize(horizontal: false, vertical: true)
                        divider
                    }

                    // Tasting notes
                    if !card.tastingNotes.isEmpty {
                        notesSection
                        divider
                    }

                    // Known ingredients (bar finds)
                    if !card.knownIngredients.isEmpty {
                        ingredientsSection
                        divider
                    }

                    // Check-in
                    checkInSection
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 48)
            }
        }
        .background(Color.Speakeasy.background.ignoresSafeArea())
        .navigationTitle(card.name)
        .navigationBarTitleDisplayMode(.large)
    }

    // MARK: Meta Badges

    private var metaBadges: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                DrinkCategoryBadge(category: card.category)

                if let abv = card.abv {
                    metaPill(String(format: "%.1f%% ABV", abv), icon: "drop")
                }
                if let vintage = card.vintage {
                    metaPill("\(vintage)", icon: "calendar")
                }
                if let producer = card.producer {
                    metaPill(producer, icon: "building.2")
                }
                if let venue = card.venueName {
                    metaPill(venue, icon: "mappin.circle")
                }
            }
        }
    }

    private func metaPill(_ label: String, icon: String) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .imageScale(.small)
            Text(label)
        }
        .font(.badgeText)
        .foregroundStyle(Color.Speakeasy.parchment)
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(Color.Speakeasy.surfaceRaised)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.Speakeasy.border, lineWidth: 0.5))
    }

    // MARK: Tasting Notes

    private var notesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader("TASTING NOTES")
            FlowLayout(spacing: 8) {
                ForEach(card.tastingNotes, id: \.self) { note in
                    Text(note)
                        .font(.callout)
                        .foregroundStyle(accentColor)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(accentColor.opacity(0.12))
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(accentColor.opacity(0.2), lineWidth: 0.5))
                }
            }
        }
    }

    // MARK: Known Ingredients (Bar Finds)

    private var ingredientsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("MENU INGREDIENTS")
            Text("Proportions not listed. Tap below to have a recipe built for you.")
                .font(.caption)
                .foregroundStyle(Color.Speakeasy.ash)

            ForEach(card.knownIngredients, id: \.self) { ingredient in
                HStack(spacing: 10) {
                    Circle()
                        .fill(accentColor)
                        .frame(width: 5, height: 5)
                    Text(ingredient.capitalized)
                        .font(.ingredientName)
                        .foregroundStyle(Color.Speakeasy.cream)
                }
            }

            Button {
                // Build Recipe — Claude API call, wired up in next milestone
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "wand.and.stars")
                    Text("Build Recipe")
                        .font(.callout.weight(.semibold))
                }
                .foregroundStyle(Color.Speakeasy.background)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.top, 4)
        }
    }

    // MARK: Check-In

    private var checkInSection: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                card.isCheckedIn.toggle()
            }
        } label: {
            HStack(spacing: 10) {
                Image(systemName: card.isCheckedIn ? "checkmark.seal.fill" : "checkmark.seal")
                    .foregroundStyle(card.isCheckedIn ? accentColor : Color.Speakeasy.ash)
                    .font(.title3)
                Text(card.isCheckedIn ? "Tried it" : "Mark as Tried")
                    .font(.callout)
                    .foregroundStyle(card.isCheckedIn ? accentColor : Color.Speakeasy.parchment)
                Spacer()
            }
            .padding(14)
            .background(Color.Speakeasy.surfaceRaised)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(card.isCheckedIn ? accentColor.opacity(0.4) : Color.Speakeasy.border,
                            lineWidth: 0.5)
            )
        }
        .buttonStyle(.plain)
    }

    // MARK: Reusable

    private var divider: some View {
        Rectangle()
            .fill(Color.Speakeasy.border)
            .frame(height: 0.5)
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.sectionLabel)
            .foregroundStyle(Color.Speakeasy.ash)
            .kerning(1.5)
    }
}

// MARK: FlowLayout — wraps tasting note chips

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        let width = proposal.width ?? 0
        var x: CGFloat = 0, y: CGFloat = 0, rowH: CGFloat = 0, maxY: CGFloat = 0
        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if x + size.width > width, x > 0 {
                y += rowH + spacing
                x = 0
                rowH = 0
            }
            rowH = max(rowH, size.height)
            x += size.width + spacing
            maxY = y + rowH
        }
        return CGSize(width: width, height: maxY)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        var x = bounds.minX, y = bounds.minY, rowH: CGFloat = 0
        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if x + size.width > bounds.maxX, x > bounds.minX {
                y += rowH + spacing
                x = bounds.minX
                rowH = 0
            }
            view.place(at: CGPoint(x: x, y: y), proposal: .unspecified)
            rowH = max(rowH, size.height)
            x += size.width + spacing
        }
    }
}

#Preview {
    NavigationStack {
        DrinkCardDetailView(card: .constant(DrinkSampleData.caymusCab))
    }
    .preferredColorScheme(.dark)
}
