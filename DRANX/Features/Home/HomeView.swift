import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    headerSection
                    featureCards
                    recentSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 40)
            }
            .background(Color.Speakeasy.background.ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }

    // MARK: Header

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("DRANX")
                .font(.system(size: 48, design: .serif))
                .fontWeight(.semibold)
                .foregroundStyle(Color.Speakeasy.cream)
                .kerning(2)

            HStack(spacing: 10) {
                Rectangle()
                    .fill(Color.Speakeasy.gold)
                    .frame(width: 28, height: 1)
                Circle()
                    .fill(Color.Speakeasy.gold)
                    .frame(width: 3, height: 3)
                Rectangle()
                    .fill(Color.Speakeasy.border)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
            }

            HStack(spacing: 8) {
                ForEach(["discover", "·", "recreate", "·", "explore"], id: \.self) { word in
                    Text(word)
                        .foregroundStyle(word == "·" ? Color.Speakeasy.gold : Color.Speakeasy.parchment)
                }
            }
            .font(.system(.caption, design: .default, weight: .regular))
            .kerning(1.8)
        }
        .padding(.top, 8)
    }

    // MARK: Feature Cards

    private var featureCards: some View {
        VStack(spacing: 12) {
            // Scan — full width, tall, primary CTA
            NavigationLink(destination: ScannerView()) {
                FeatureCard(
                    eyebrow: "SCAN THE BAR",
                    title: "What can you make tonight?",
                    subtitle: "Point your camera at any bottle or menu item to get started.",
                    symbol: "camera.viewfinder",
                    gradientStart: Color(hex: "1A1410"),
                    gradientEnd: Color(hex: "2E1F08"),
                    accentColor: Color.Speakeasy.gold,
                    height: 190
                )
            }
            .buttonStyle(.plain)

            // Drinks + Recipes side by side
            HStack(spacing: 12) {
                NavigationLink(destination: DrinksView()) {
                    FeatureCard(
                        eyebrow: "DRINKS",
                        title: "Your passport.",
                        subtitle: "Discover, check in, explore.",
                        symbol: "wineglass.fill",
                        gradientStart: Color(hex: "160E14"),
                        gradientEnd: Color(hex: "2A0E1E"),
                        accentColor: Color(hex: "9B3A5A"),
                        height: 170
                    )
                }
                .buttonStyle(.plain)

                NavigationLink(destination: RecipesView()) {
                    FeatureCard(
                        eyebrow: "RECIPES",
                        title: "Make it at home.",
                        subtitle: "Craft, recreate, refine.",
                        symbol: "list.bullet.rectangle",
                        gradientStart: Color(hex: "0E1418"),
                        gradientEnd: Color(hex: "0A1C22"),
                        accentColor: Color(hex: "4A7C8B"),
                        height: 170
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }

    // MARK: Recent

    private var recentSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("RECENTLY ADDED")
                    .font(.sectionLabel)
                    .foregroundStyle(Color.Speakeasy.ash)
                    .kerning(1.5)
                Spacer()
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(DrinkSampleData.cards.prefix(3)) { card in
                        RecentChip(
                            name: card.name,
                            detail: card.origin?.shortDisplay ?? card.venueName ?? card.category.rawValue,
                            symbol: card.category.symbol,
                            accentHex: card.category.accentHex
                        )
                    }
                    ForEach(SampleData.recipes.prefix(2)) { recipe in
                        RecentChip(
                            name: recipe.name,
                            detail: recipe.glassware ?? recipe.category.rawValue,
                            symbol: recipe.category.symbol,
                            accentHex: "C8A96E"
                        )
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }
}

// MARK: FeatureCard

private struct FeatureCard: View {
    let eyebrow: String
    let title: String
    let subtitle: String
    let symbol: String
    let gradientStart: Color
    let gradientEnd: Color
    let accentColor: Color
    let height: CGFloat

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background gradient
            LinearGradient(
                colors: [gradientStart, gradientEnd],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            // Watermark symbol
            Image(systemName: symbol)
                .font(.system(size: 110, weight: .thin))
                .foregroundStyle(accentColor.opacity(0.07))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(.top, 12)
                .padding(.trailing, -10)

            // Subtle top accent line
            VStack {
                Rectangle()
                    .fill(accentColor.opacity(0.5))
                    .frame(height: 1)
                Spacer()
            }

            // Content
            VStack(alignment: .leading, spacing: 5) {
                Text(eyebrow)
                    .font(.badgeText)
                    .foregroundStyle(accentColor)
                    .kerning(1.2)

                Text(title)
                    .font(.recipeTitle)
                    .foregroundStyle(Color.Speakeasy.cream)
                    .fixedSize(horizontal: false, vertical: true)

                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(Color.Speakeasy.parchment)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(accentColor.opacity(0.15), lineWidth: 0.5)
        )
    }
}

// MARK: RecentChip

private struct RecentChip: View {
    let name: String
    let detail: String
    let symbol: String
    let accentHex: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: symbol)
                .foregroundStyle(Color(hex: accentHex))
                .frame(width: 28)

            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.Speakeasy.cream)
                    .lineLimit(1)
                Text(detail)
                    .font(.caption2)
                    .foregroundStyle(Color.Speakeasy.parchment)
                    .lineLimit(1)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color.Speakeasy.surfaceRaised)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.Speakeasy.border, lineWidth: 0.5)
        )
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
