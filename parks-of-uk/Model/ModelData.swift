import Foundation

@Observable
class ModelData {
    var parks: [Park] = []
    
    var features: [Park] {
        parks.filter { $0.isFeatured }
    }
    
    var categories: [String: [Park]] {
        Dictionary(grouping: parks, by: { $0.country})
    }
    
    init() {
        load()
    }
    
    private func load() {
        Task {
            do {
                self.parks = try await loadParks()
            } catch {
                fatalError("Error loading parks: \(error)")
            }
        }
    }
    
    private func loadParks() async throws -> [Park] {
        guard let file = Bundle.main.url(forResource: "Parks", withExtension: "json") 
        else {
            fatalError("Parks.json not found")
        }
        let data = try Data(contentsOf: file)
        let decoder = JSONDecoder()
        return try decoder.decode([Park].self, from: data)
    }
}

extension ModelData {
    static var mock: ModelData {
        let instance = ModelData()
        
        instance.parks = [
            Park(
                id: 3,
                name: "Exmoor",
                country: "England",
                isFavorite: false,
                isFeatured: true,
                imageURL: "https://www.nationalparks.uk/app/uploads/2020/07/Hero-image_exmoor_exp_autumn_valley_of_rocks_2019_cf025397_final_WEB-600x400.jpg",
                description: "Towering sea cliffs, high moors, tumbling streams and deep valleys that shelter our unique Atlantic Rain forest. On Exmoor it is still possible to find tranquillity and peace as well as rediscover your sense of adventure; to catch a glimpse of wild red deer, be amazed by dark skies full of stars and explore quaint villages full of character and charm.",
                keyActivities: "Walking, South West Coast Path, Stargazing",
                website: "https://www.exmoor-nationalpark.gov.uk",
                coordinates: Park.Coordinates(latitude: 54.4785, longtitude: -3.0655)
            ),
            Park(
                id: 12,
                name: "Loch Lomond & The Trossachs",
                country: "Scotland",
                isFavorite: true,
                isFeatured: true,
                imageURL: "https://www.nationalparks.uk/app/uploads/2020/09/Hero_Loch_Lomond-600x400.jpg",
                description: "A place where the lowlands and highlands meet, with varied scenery of rolling lowland landscapes, tranquil lochs and rugged mountains in the north.\nThese landscapes create a diverse range of habitats for a variety of wildlife including red squirrels, black grouse, golden eagles, osprey, pine marten and otters. The National Park Authority works to inspire communities, visitors and partners to enhance and protect this special place.",
                keyActivities: "Walking, Cycling, Watching wildlife",
                website: "https://www.lochlomond-trossachs.org",
                coordinates: Park.Coordinates(latitude: 56.2303, longtitude: -4.5392)
            )
        ]
        return instance
    }
}
