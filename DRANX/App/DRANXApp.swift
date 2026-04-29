import SwiftUI

@main
struct DRANXApp: App {
    init() {
        applyAppearance()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }

    private func applyAppearance() {
        let tabBar = UITabBarAppearance()
        tabBar.configureWithOpaqueBackground()
        tabBar.backgroundColor = UIColor(Color(hex: "1C1712"))
        UITabBar.appearance().standardAppearance    = tabBar
        UITabBar.appearance().scrollEdgeAppearance  = tabBar

        let navBar = UINavigationBarAppearance()
        navBar.configureWithOpaqueBackground()
        navBar.backgroundColor = UIColor(Color(hex: "0E0B08"))
        navBar.titleTextAttributes = [
            .foregroundColor: UIColor(Color(hex: "F2E8D5"))
        ]
        navBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color(hex: "F2E8D5"))
        ]
        UINavigationBar.appearance().standardAppearance   = navBar
        UINavigationBar.appearance().scrollEdgeAppearance = navBar
        UINavigationBar.appearance().tintColor            = UIColor(Color(hex: "C8A96E"))
    }
}
