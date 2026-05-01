import SwiftUI

struct ScannerView: View {
    var body: some View {
        Text("Point your camera at bottles to detect what's available.")
            .foregroundStyle(Color.Speakeasy.parchment)
            .navigationTitle("Scan Bar")
            .background(Color.Speakeasy.background.ignoresSafeArea())
    }
}

#Preview {
    NavigationStack {
        ScannerView()
    }
    .preferredColorScheme(.dark)
}
