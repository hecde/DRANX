import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                HomeView(selectedTab: $selectedTab)
            }
            .tabItem { Label("Home", systemImage: "house.fill") }
            .tag(0)

            NavigationStack {
                DrinksView()
            }
            .tabItem { Label("Drinks", systemImage: "wineglass") }
            .tag(1)

            NavigationStack {
                RecipesView()
            }
            .tabItem { Label("Recipes", systemImage: "list.bullet.rectangle") }
            .tag(2)
        }
        .tint(Color.Speakeasy.gold)
    }
}

#Preview {
    ContentView()
}
