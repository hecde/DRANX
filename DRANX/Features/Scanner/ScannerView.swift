import SwiftUI

struct ScannerView: View {
    var body: some View {
        NavigationStack {
            Text("Point your camera at bottles to detect what's available.")
                .navigationTitle("Scan Bar")
        }
    }
}

#Preview {
    ScannerView()
}
