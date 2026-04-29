import SwiftUI

struct IngredientRowView: View {
    @Binding var ingredient: Ingredient
    let isEditing: Bool
    var onDelete: (() -> Void)? = nil

    @State private var isSubsExpanded  = false
    @State private var showingSubInput = false
    @State private var newSubstitution = ""

    var body: some View {
        if isEditing {
            editingView
        } else {
            displayView
        }
    }

    // MARK: Display

    private var displayView: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text(ingredient.formattedQuantity)
                    .font(.measurement)
                    .foregroundStyle(Color.Speakeasy.gold)
                    .frame(width: 34, alignment: .trailing)

                Group {
                    if ingredient.unit.usesQuantity {
                        Text(ingredient.unit.rawValue)
                            .font(.unitLabel)
                            .foregroundStyle(Color.Speakeasy.parchment)
                    } else {
                        Text(ingredient.unit.rawValue)
                            .font(.unitLabel)
                            .foregroundStyle(Color.Speakeasy.ash)
                    }
                }
                .frame(width: 48, alignment: .leading)
                .padding(.leading, 6)

                HStack(spacing: 6) {
                    Text(ingredient.name)
                        .font(.ingredientName)
                        .foregroundStyle(Color.Speakeasy.cream)
                    if ingredient.isOptional {
                        Text("opt.")
                            .font(.badgeText)
                            .foregroundStyle(Color.Speakeasy.ash)
                    }
                }

                Spacer()

                if !ingredient.substitutions.isEmpty {
                    Button {
                        withAnimation(.easeInOut(duration: 0.18)) {
                            isSubsExpanded.toggle()
                        }
                    } label: {
                        Image(systemName: isSubsExpanded ? "chevron.up" : "arrow.triangle.2.circlepath")
                            .imageScale(.small)
                            .foregroundStyle(Color.Speakeasy.goldMuted)
                    }
                    .buttonStyle(.plain)
                }
            }

            if isSubsExpanded {
                ForEach(ingredient.substitutions, id: \.self) { sub in
                    HStack(spacing: 6) {
                        Spacer().frame(width: 88)
                        Image(systemName: "arrow.turn.down.right")
                            .imageScale(.small)
                            .foregroundStyle(Color.Speakeasy.ash)
                        Text("or \(sub)")
                            .font(.caption)
                            .foregroundStyle(Color.Speakeasy.parchment)
                    }
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
        }
        .padding(.vertical, 6)
    }

    // MARK: Editing

    private var editingView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                if ingredient.unit.usesQuantity {
                    TextField("Qty", text: quantityText)
                        .textFieldStyle(.plain)
                        .keyboardType(.decimalPad)
                        .font(.measurement)
                        .foregroundStyle(Color.Speakeasy.gold)
                        .multilineTextAlignment(.center)
                        .frame(width: 52)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 7)
                        .background(Color.Speakeasy.surface)
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                }

                unitPicker

                TextField("Ingredient name", text: $ingredient.name)
                    .textFieldStyle(.plain)
                    .font(.ingredientName)
                    .foregroundStyle(Color.Speakeasy.cream)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 7)
                    .background(Color.Speakeasy.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 7))

                if let onDelete {
                    Button(action: onDelete) {
                        Image(systemName: "trash")
                            .imageScale(.small)
                            .foregroundStyle(Color.Speakeasy.destructive)
                    }
                    .buttonStyle(.plain)
                }
            }

            Toggle(isOn: $ingredient.isOptional) {
                Text("Optional ingredient")
                    .font(.caption)
                    .foregroundStyle(Color.Speakeasy.parchment)
            }
            .tint(Color.Speakeasy.gold)

            substitutionsEditor
        }
        .padding(.vertical, 6)
    }

    private var unitPicker: some View {
        Menu {
            ForEach(MeasurementUnit.UnitCategory.allCases) { cat in
                Section(cat.rawValue) {
                    ForEach(MeasurementUnit.allCases.filter { $0.category == cat }) { unit in
                        Button(unit.rawValue) { ingredient.unit = unit }
                    }
                }
            }
        } label: {
            HStack(spacing: 3) {
                Text(ingredient.unit.rawValue)
                    .font(.unitLabel)
                    .foregroundStyle(Color.Speakeasy.parchment)
                Image(systemName: "chevron.up.chevron.down")
                    .imageScale(.small)
                    .foregroundStyle(Color.Speakeasy.ash)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 7)
            .background(Color.Speakeasy.surface)
            .clipShape(RoundedRectangle(cornerRadius: 7))
        }
    }

    private var substitutionsEditor: some View {
        VStack(alignment: .leading, spacing: 6) {
            if !ingredient.substitutions.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(ingredient.substitutions.indices, id: \.self) { i in
                            SubstitutionChip(text: ingredient.substitutions[i]) {
                                ingredient.substitutions.remove(at: i)
                            }
                        }
                    }
                    .padding(.vertical, 2)
                }
            }

            if showingSubInput {
                HStack(spacing: 8) {
                    TextField("e.g. Rye Whiskey", text: $newSubstitution)
                        .textFieldStyle(.plain)
                        .font(.caption)
                        .foregroundStyle(Color.Speakeasy.cream)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                        .background(Color.Speakeasy.surface)
                        .clipShape(RoundedRectangle(cornerRadius: 6))

                    Button("Add") {
                        let trimmed = newSubstitution.trimmingCharacters(in: .whitespaces)
                        if !trimmed.isEmpty { ingredient.substitutions.append(trimmed) }
                        newSubstitution = ""
                        showingSubInput = false
                    }
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.Speakeasy.gold)

                    Button("Cancel") {
                        newSubstitution = ""
                        showingSubInput = false
                    }
                    .font(.caption)
                    .foregroundStyle(Color.Speakeasy.parchment)
                }
            } else {
                Button {
                    showingSubInput = true
                } label: {
                    Label("Add substitution", systemImage: "plus.circle")
                        .font(.caption)
                        .foregroundStyle(Color.Speakeasy.goldMuted)
                }
                .buttonStyle(.plain)
            }
        }
    }

    // MARK: Helpers

    private var quantityText: Binding<String> {
        Binding(
            get: {
                guard let qty = ingredient.quantity else { return "" }
                return qty.truncatingRemainder(dividingBy: 1) == 0
                    ? String(Int(qty))
                    : String(qty)
            },
            set: { ingredient.quantity = Double($0) }
        )
    }
}

struct SubstitutionChip: View {
    let text: String
    let onRemove: () -> Void

    var body: some View {
        HStack(spacing: 4) {
            Text(text)
                .font(.badgeText)
                .foregroundStyle(Color.Speakeasy.parchment)
            Button(action: onRemove) {
                Image(systemName: "xmark")
                    .imageScale(.small)
                    .foregroundStyle(Color.Speakeasy.ash)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.Speakeasy.border)
        .clipShape(Capsule())
    }
}
