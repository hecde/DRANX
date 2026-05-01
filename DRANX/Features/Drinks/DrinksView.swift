import SwiftUI

struct DrinksView: View {
    @State private var cards          = DrinkSampleData.cards
    @State private var selectedFilter: DrinkCardCategory? = nil

    var body: some View {
        VStack(spacing: 0) {
            filterBar
                .padding(.vertical, 10)

            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach($cards) { $card in
                        if selectedFilter == nil || card.category == selectedFilter {
                            NavigationLink(destination: DrinkCardDetailView(card: $card)) {
                                DrinkCardView(card: card)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 4)
                .padding(.bottom, 24)
            }
        }
        .background(Color.Speakeasy.background.ignoresSafeArea())
        .navigationTitle("Drinks")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // Import menu / add drink — next milestone
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(Color.Speakeasy.gold)
                }
            }
        }
    }

    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                FilterChip(label: "All", isSelected: selectedFilter == nil) {
                    withAnimation(.easeInOut(duration: 0.18)) { selectedFilter = nil }
                }
                ForEach(DrinkCardCategory.allCases) { cat in
                    FilterChip(
                        label: cat.rawValue,
                        isSelected: selectedFilter == cat,
                        accentHex: cat.accentHex
                    ) {
                        withAnimation(.easeInOut(duration: 0.18)) {
                            selectedFilter = selectedFilter == cat ? nil : cat
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct FilterChip: View {
    let label: String
    let isSelected: Bool
    var accentHex: String = "C8A96E"
    let action: () -> Void

    private var accent: Color { Color(hex: accentHex) }

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.badgeText)
                .foregroundStyle(isSelected ? Color.Speakeasy.background : Color.Speakeasy.parchment)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(isSelected ? accent : Color.Speakeasy.surfaceRaised)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(isSelected ? .clear : Color.Speakeasy.border, lineWidth: 0.5))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        DrinksView()
    }
    .preferredColorScheme(.dark)
}
