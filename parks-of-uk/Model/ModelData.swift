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
        guard let file = Bundle.main.url(forResource: "Parks", withExtension: "json") else {
            fatalError("Parks.json not found")
        }
        let data = try Data(contentsOf: file)
        let decoder = JSONDecoder()
        return try decoder.decode([Park].self, from: data)
    }
}
