//
//  ModelData.swift
//  parks-of-uk
//
//  Created by Mary Cherkas on 21/02/2024.
//

import Foundation

@Observable
class ModelData {
    var parks: [Park] = load("Parks.json")
    
    var categories: [String: [Park]] {
        Dictionary(grouping: parks, by: { $0.country})
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

