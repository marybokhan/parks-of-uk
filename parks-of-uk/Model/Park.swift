import Foundation
import SwiftUI
import CoreLocation

struct Park: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var country: String
    var isFavorite: Bool
    var isFeatured: Bool
    var description: String
    var keyActivities: String
    var website: String
    
    private var imageURL: String
    var image: Image? {
        guard let url = URL(string: imageURL),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data)
        else {
            return nil
        }
        return Image(uiImage: image)
    }
    
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
