import SwiftUI
import MapKit

struct OriginMapView: View {
    let origin: Origin

    private var region: MKCoordinateRegion {
        guard let coord = origin.coordinate else {
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 20, longitude: 0),
                span: MKCoordinateSpan(latitudeDelta: 60, longitudeDelta: 60)
            )
        }
        return MKCoordinateRegion(
            center: coord,
            span: MKCoordinateSpan(latitudeDelta: 1.8, longitudeDelta: 1.8)
        )
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let coord = origin.coordinate {
                Map(coordinateRegion: .constant(region),
                    interactionModes: [],
                    annotationItems: [OriginPin(coordinate: coord)]) { pin in
                    MapMarker(coordinate: pin.coordinate, tint: Color.Speakeasy.gold)
                }
                .colorScheme(.dark)
                .allowsHitTesting(false)
            } else {
                Color.Speakeasy.surfaceRaised
                Image(systemName: "map")
                    .font(.largeTitle)
                    .foregroundStyle(Color.Speakeasy.ash)
            }

            // Origin label overlay
            VStack(alignment: .leading, spacing: 2) {
                if let locality = origin.locality ?? origin.region {
                    Text(locality)
                        .font(.sectionLabel)
                        .foregroundStyle(Color.Speakeasy.cream)
                        .kerning(0.8)
                }
                Text(origin.country)
                    .font(.caption2)
                    .foregroundStyle(Color.Speakeasy.parchment)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(12)
        }
    }
}

private struct OriginPin: Identifiable {
    let id  = UUID()
    let coordinate: CLLocationCoordinate2D
}
