import SwiftUI
import MapKit

struct MapView: View {
    var cooordinate: CLLocationCoordinate2D
    
    var body: some View {
        Map(position: .constant(.region(region)))
    }
    
    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: cooordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
}

#Preview {
    MapView(cooordinate: CLLocationCoordinate2D(latitude: 52.58774,
                                                longitude: 1.61496))
}
