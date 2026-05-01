import SwiftUI

struct RecipesView: View {
    @State private var recipes = SampleData.recipes

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach($recipes) { $recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: $recipe)) {
                        RecipeCardView(recipe: recipe)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 24)
        }
        .background(Color.Speakeasy.background.ignoresSafeArea())
        .navigationTitle("Recipes")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // Add recipe — coming soon
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(Color.Speakeasy.gold)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecipesView()
    }
    .preferredColorScheme(.dark)
}
