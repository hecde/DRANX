import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ScannerView()
                .tabItem {
                    Label("Scan", systemImage: "camera.viewfinder")
                }

            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "list.bullet.rectangle")
                }

            MenuScanView()
                .tabItem {
                    Label("Menu", systemImage: "text.viewfinder")
                }
        }
    }
}

#Preview {
    ContentView()
}
