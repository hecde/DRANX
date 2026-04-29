import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }

            DrinksView()
                .tabItem { Label("Drinks", systemImage: "wineglass") }

            RecipesView()
                .tabItem { Label("Recipes", systemImage: "list.bullet.rectangle") }
        }
        .tint(Color.Speakeasy.gold)
    }
}

#Preview {
    ContentView()
}
