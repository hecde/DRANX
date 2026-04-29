import SwiftUI

struct RecipesView: View {
    var body: some View {
        NavigationStack {
            Text("Recipes for your scanned bottles will appear here.")
                .navigationTitle("Recipes")
        }
    }
}

#Preview {
    RecipesView()
}
