//
//  MapView.swift
//  parks-of-uk
//
//  Created by Mary Cherkas on 21/02/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    var cooordinate = CLLocationCoordinate2D(latitude: 52.58774,
                                            longitude: 1.61496)
    
    var body: some View {
        if #available(iOS 17.0, *) {
            Map(position: .constant(.region(region)))
        } else {
            // Fallback on earlier versions
        }
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
