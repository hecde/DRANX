import SwiftUI

struct MenuScanView: View {
    var body: some View {
        NavigationStack {
            Text("Scan a drink description from a menu to create a shareable recipe.")
                .navigationTitle("Scan Menu")
        }
    }
}

#Preview {
    MenuScanView()
}
