import Foundation
import SwiftUI
import CoreLocation

struct Park: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var country: String
    var isFavorite: Bool
    var isFeatured: Bool
    var imageURL: String
    var description: String
    var keyActivities: String
    var website: String
    
    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longtitude
        )
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longtitude: Double
    }
}
