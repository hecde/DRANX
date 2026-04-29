import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ScannerView()
                .tabItem { Label("Scan", systemImage: "camera.viewfinder") }

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
