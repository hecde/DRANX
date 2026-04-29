import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: Recipe
    @State private var isEditing = false
    @State private var draft: Recipe

    init(recipe: Binding<Recipe>) {
        self._recipe = recipe
        self._draft  = State(initialValue: recipe.wrappedValue)
    }

    private var displayed: Recipe { isEditing ? draft : recipe }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                headerSection
                    .padding(.top, 4)

                divider.padding(.vertical, 20)

                ingredientsSection

                divider.padding(.vertical, 20)

                stepsSection
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 48)
        }
        .background(Color.Speakeasy.background.ignoresSafeArea())
        .navigationTitle(displayed.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar { toolbarItems }
    }

    // MARK: Toolbar

    @ToolbarContentBuilder
    private var toolbarItems: some ToolbarContent {
        if isEditing {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    draft      = recipe
                    isEditing  = false
                }
                .foregroundStyle(Color.Speakeasy.parchment)
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            if isEditing {
                Button("Save") {
                    recipe    = draft
                    isEditing = false
                }
                .font(.body.weight(.semibold))
                .foregroundStyle(Color.Speakeasy.gold)
            } else {
                Button("Edit") {
                    draft     = recipe
                    isEditing = true
                }
                .foregroundStyle(Color.Speakeasy.gold)
            }
        }
    }

    // MARK: Header

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                CategoryBadge(category: displayed.category)

                if let glassware = displayed.glassware {
                    HStack(spacing: 4) {
                        Image(systemName: "wineglass")
                            .imageScale(.small)
                        Text(glassware)
                    }
                    .font(.badgeText)
                    .foregroundStyle(Color.Speakeasy.parchment)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color.Speakeasy.surfaceRaised)
                    .clipShape(Capsule())
                }

                Spacer()

                if let prep = displayed.prepTimeMinutes {
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .imageScale(.small)
                        Text("\(prep) min")
                    }
                    .font(.badgeText)
                    .foregroundStyle(Color.Speakeasy.parchment)
                }
            }

            if let desc = displayed.description {
                Text(desc)
                    .font(.callout)
                    .foregroundStyle(Color.Speakeasy.parchment)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    // MARK: Ingredients

    private var ingredientsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionHeader("INGREDIENTS")

            if isEditing {
                ForEach($draft.ingredients) { $ingredient in
                    IngredientRowView(
                        ingredient: $ingredient,
                        isEditing: true,
                        onDelete: { draft.ingredients.removeAll { $0.id == ingredient.id } }
                    )
                    .padding(.vertical, 4)
                    divider
                }

                Button {
                    draft.ingredients.append(Ingredient(name: "", quantity: 1, unit: .ounce))
                } label: {
                    Label("Add Ingredient", systemImage: "plus.circle.fill")
                        .font(.callout)
                        .foregroundStyle(Color.Speakeasy.gold)
                }
                .padding(.top, 4)
            } else {
                ForEach($recipe.ingredients) { $ingredient in
                    IngredientRowView(ingredient: $ingredient, isEditing: false)
                    if ingredient.id != recipe.ingredients.last?.id {
                        divider
                    }
                }
            }
        }
    }

    // MARK: Steps

    private var stepsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionHeader("STEPS")

            ForEach(Array(displayed.steps.enumerated()), id: \.offset) { index, step in
                HStack(alignment: .top, spacing: 14) {
                    Text("\(index + 1)")
                        .font(.measurement)
                        .foregroundStyle(Color.Speakeasy.gold)
                        .frame(width: 22, alignment: .trailing)

                    Text(step)
                        .font(.stepText)
                        .foregroundStyle(Color.Speakeasy.cream)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }

    // MARK: Reusable pieces

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

#Preview {
    NavigationStack {
        RecipeDetailView(recipe: .constant(SampleData.oldFashioned))
    }
    .preferredColorScheme(.dark)
}
