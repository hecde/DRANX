import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe

    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(Color.Speakeasy.gold)
                .frame(width: 3)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    CategoryBadge(category: recipe.category)
                    Spacer()
                    if let glassware = recipe.glassware {
                        Text(glassware)
                            .font(.badgeText)
                            .foregroundStyle(Color.Speakeasy.ash)
                    }
                }

                Text(recipe.name)
                    .font(.recipeTitle)
                    .foregroundStyle(Color.Speakeasy.cream)

                HStack(spacing: 14) {
                    Label("\(recipe.ingredients.count) ingredients", systemImage: "list.bullet")
                        .font(.caption)
                        .foregroundStyle(Color.Speakeasy.parchment)

                    if let prep = recipe.prepTimeMinutes {
                        Label("\(prep) min", systemImage: "clock")
                            .font(.caption)
                            .foregroundStyle(Color.Speakeasy.parchment)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .background(Color.Speakeasy.surfaceRaised)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.Speakeasy.border, lineWidth: 0.5)
        )
    }
}

struct CategoryBadge: View {
    let category: RecipeCategory

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: category.symbol)
                .imageScale(.small)
            Text(category.rawValue.uppercased())
        }
        .font(.badgeText)
        .foregroundStyle(Color.Speakeasy.gold)
        .padding(.horizontal, 8)
        .padding(.vertical, 3)
        .background(Color.Speakeasy.goldMuted.opacity(0.25))
        .clipShape(Capsule())
    }
}

#Preview {
    ZStack {
        Color.Speakeasy.background.ignoresSafeArea()
        VStack(spacing: 12) {
            RecipeCardView(recipe: SampleData.oldFashioned)
            RecipeCardView(recipe: SampleData.negroni)
        }
        .padding()
    }
}
